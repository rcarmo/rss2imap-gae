#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
Decorator functions

Created by: Rui Carmo
"""

from bottle import request, response, route, abort
import time, binascii, hashlib, email.utils, functools, json
from datetime import datetime
import logging

from google.appengine.api import memcache

log = logging.getLogger()

gmt_format_string = "%a, %d %b %Y %H:%M:%S GMT"


class CustomEncoder(json.JSONEncoder):
    """Custom encoder that serializes datetimes into JS-compliant times"""

    def default(self, obj):
        if isinstance(obj, datetime):
            epoch = datetime.utcfromtimestamp(0)
            delta = obj - epoch
            return int(delta.total_seconds()) * 1000
        return json.JSONEncoder.default(self, obj)


def cache_memory(ns='url', ttl=3600):
    """Cache route results in Memcache"""

    def decorator(callback):
        @functools.wraps(callback)
        def wrapper(*args, **kwargs):
            try:
                item = json.loads(memcache.get(request.urlparts.path, namespace=ns))
                body = item['body']
                for h in item['headers']:
                    response.set_header(str(h), item['headers'][h])
                response.set_header('X-Source', 'Memcache')
            except Exception as e:
                log.debug("Cache miss for %s: %s" % (request.urlparts.path, e))
                body = callback(*args, **kwargs)
                item = {
                    'body': body,
                    'headers': dict(response.headers),
                    'mtime': int(time.time())
                }
                memcache.set(request.urlparts.path, json.dumps(item), time=ttl, namespace=ns)
            return body
        return wrapper
    return decorator


def cache_results(timeout=0):
    """Cache route results for a given period of time"""

    def decorator(callback):
        _cache = {}
        _times = {}

        @functools.wraps(callback)
        def wrapper(*args, **kwargs):

            def expire(when):
                for t in [k for k in _times.keys()]:
                    if (when - t) > timeout:
                        del(_cache[_times[t]])
                        del(_times[t])

            now = time.time()
            try:
                item = _cache[request.urlparts]
                if 'If-Modified-Since'  in request.headers:
                    try:
                        since = time.mktime(email.utils.parsedate(request.headers['If-Modified-Since']))
                    except:
                        since = now
                    if item['mtime'] >= since:
                        expire(now)
                        abort(304,'Not modified')
                for h in item['headers']:
                    response.set_header(str(h), item['headers'][h])
                body = item['body']
                response.set_header('X-Source', 'Worker Cache')
            except KeyError:
                body = callback(*args, **kwargs)
                item = {
                    'body': body,
                    'headers': response.headers,
                    'mtime': int(now)
                }
                _cache[request.urlparts] = item
                _times[now] = request.urlparts

            expire(now)
            return body
        return wrapper
    return decorator


def cache_control(seconds = 0):
    """Insert HTTP caching headers"""

    def decorator(callback):
        @functools.wraps(callback)
        def wrapper(*args, **kwargs):
            expires = int(time.time() + seconds)
            expires = time.strftime(gmt_format_string, time.gmtime(expires))
            response.set_header('Expires', expires)
            if seconds:
                pragma = 'public'
            else:
                pragma = 'no-cache, must-revalidate'
            response.set_header('Cache-Control', "%s, max-age=%s" % (pragma, seconds))
            response.set_header('Pragma', pragma)
            return callback(*args, **kwargs)
        return wrapper
    return decorator


def timed(callback):
    """Decorator for timing route processing"""

    @functools.wraps(callback)
    def wrapper(*args, **kwargs):
        start = time.time()
        body = callback(*args, **kwargs)
        end = time.time()
        response.set_header('X-Processing-Time', str(end - start))
        return body
    return wrapper


def jsonp(callback):
    """Decorator for JSONP handling"""

    @functools.wraps(callback)
    def wrapper(*args, **kwargs):
        body = callback(*args, **kwargs)
        try:
            body = json.dumps(body, cls=CustomEncoder)
            # Set content type only if serialization successful
            response.content_type = 'application/json'
        except Exception, e:
            return body

        callback_function = request.query.get('callback')
        if callback_function:
            body = ''.join([callback_function, '(', body, ')'])
            response.content_type = 'text/javascript'

        response.set_header('Last-Modified', time.strftime(gmt_format_string, time.gmtime()))
        response.set_header('ETag', binascii.b2a_base64(hashlib.sha1(body).digest()).strip())
        response.set_header('Content-Length', len(body))
        return body
    return wrapper


def memoize(f):
    """Memoization decorator for functions taking one or more arguments"""

    class memodict(dict):
        def __init__(self, f):
            self.f = f

        def __call__(self, *args):
            return self[args]

        def __missing__(self, key):
            res = self[key] = self.f(*key)
            return res

        def __repr__(self):
            return self.f.__doc__
        
        def __get__(self, obj, objtype):
            return functools.partial(self.__call__, obj)
    return memodict(f)
