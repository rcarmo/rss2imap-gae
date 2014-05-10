rss2imap-gae
============

A reboot of [rss2imap][r2i] written in [Hy][hy], designed to run on [Google App Engine][gae].

## Why?

[rss2imap][r2i] is the way I consume all my RSS feeds, but the existing codebase is archaic and in dire need of major refactoring. My [current version][r2i] works, but I had [a much nicer aggregator][bf] in the works and always meant to finish that somehow.

## Why [Hy][hy]??

[Hy][hy] is a LISP dialect that compiles down to [Python][py] bytecode, and I wanted to get a feel for it on a small-to-medium-sized codebase. Getting it to run on [GAE][gae] was easy enough and the startup times are better than [Clojure][clj], so at one point this became a little more than an experiment and one bolt short of a full functional programming lab (although I'll freely grant that the whole thing seems more than a little nuts).

## Architecture

There's nothing overly sophisticated about this at the moment. Feed URLs go into the data store, task queues turn URLs into items (probably with some post-processing in the future), items will be delivered via IMAP to subscribers.

A core assumption here is that users (like myself) will be using Gmail (at least while it still provides IMAP) and create a separate account with [an application-only password][gh] so that `rss2imap-gae` doesn't have to store their actual passwords (but yes, it does have to store _something_, and I'll be exploring alternatives).

[GAE][gae] makes it trivial to authenticate users, so this is going to have a minimal web UI for managing feed subscriptions. I'm trying out [Mithril][m] to build it in an FRP-like fashion, which may or may not entail adding [wisp][w] to the mix for that extra LISPy feeling.

[r2i]: https://github.com/rcarmo/rss2imap
[gae]: https://developers.google.com/appengine/
[hy]: http://hylang.org
[bf]: https://github.com/rcarmo/bottle-fever
[py]: http://www.python.org
[clj]: http://clojure.org
[m]: http://lhorie.github.io/mithril/
[w]: https://github.com/gozala/wisp
[gh]: https://support.google.com/mail/answer/1173270?hl=en
