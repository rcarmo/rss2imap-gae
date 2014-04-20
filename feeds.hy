(import
    os sys
    [logging              [getLogger]]
    [time                 [mktime time]]
    [hashlib              [sha1]]
    [models               [Feed]]
    [google.appengine.ext [ndb]]
    [google.appengine.api [memcache]])

(setv log (getLogger))

; Entry handling

(defn get-entry-title [entry]
    ; Returns the entry title, if any

    (get entry "title" "Untitled"))


(defn get-entry-id [entry]
    ; Get a useful id from a feed entry

    (let [[id      (get entry "id" None)]
          [content (get-entry-content entry)]
          [link    (get entry "link" None)]
          [title   (get-entry-title entry)]]
        (if id
            (if (is dict (type id))
                (get (.values id) 0)
                id))
            ; find the first non-None item that may be useful to us and hash it
            (.hexdigest (sha1 (.encode
                (car (list (filter
                    (fn [x] (not (None? x)))
                    [link content title])))
                "utf-8")))))


(defn get-entry-tags [entry]
    ; Grab post tags/categories

    (let [[tags (get entry "tags" [])]]
        (.join "," (set (list-comp (get tag term) [tag tags])))))


(defn get-entry-author [entry]
    ; Select the best author information

    (get (get entry "author_detail" {"name" None}) "name" None))
    

(defn get-entry-timestamp [entry]
    ; Select the best timestamp for an entry

    (for [header ["modified" "issued" "created"]]
        (let [[when (get entry (+ header "_parsed") None)]]
            (if when
                (mktime when))))
    (time))


(defn get-entry-content [entry]
    ; Select the best content from an entry

    (let [[candidates (+ (get entry "content" [])
                         (get entry "summary_detail" []))]]

        (for [c candidates]
            (if (in "html" (get c "type" ""))
                (get c "value")))
        (get (get candidates 0) "value" "")))


; Feed instance handling

(defn get-all-feeds []
    ; Return an iterator with all known feeds

    (for [i (ndb.gql "SELECT id, url FROM Feed")]
        (yield i)))


(defn add-feed [url]
    ; Add a feed 

    (let [[f (apply Feed [] {"url" url})]]
        (.put f)))
