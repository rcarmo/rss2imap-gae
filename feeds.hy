(import
    os sys
    [logging              [getLogger]]
    [models               [Feed]]
    [google.appengine.ext [ndb]]
    [google.appengine.api [memcache]])

(setv log (getLogger))

(defn get-all-feeds []
    nil)
