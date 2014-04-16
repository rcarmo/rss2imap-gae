(import os sys logging [time [mktime time]] [hashlib [sha1]])

(setv log (.getLogger logging))

(defn get-title [entry]
    """Returns the entry title, if any"""
    (get entry "title" "Untitled"))


(defn get-entry-id [entry]
    """Get a useful id from a feed entry"""

    (let [[id      (get entry "id" nil)
           content (get-entry-content entry)
           link    (get entry "link" nil)
           title   (get entry "title" nil)]]
        (if id
            (if (is dict (type id))
                (get (.values id) 0)
                id))
            ; find the first non-nil item that may be useful to us and hash it
            (.hexdigest (sha1 (.encode
                (car (list (filter
                    (fn [x] (not (nil? x)))
                    [link content title])))
                "utf-8")))))


(defn get-entry-tags [entry]
    """Grab post tags/categories"""

    (let [[tags (get entry "tags" [])]]
        (.join ',' (set (list-comp (get tag term) [tag tags])))))


(defn get-entry-author [entry]
    """Select the best author information"""

    (get (get entry "author_detail" {"name" nil}) "name" nil))
    

(defn get-entry-timestamp [entry]
    """Select the best timestamp for an entry"""

    (for [header ["modified" "issued" "created"]]
        (let [[when (get entry (+ header "_parsed") nil)]]
            (if when
                (mktime when))))
    (time))


(defn get-entry-content [entry]
    """Select the best content from an entry"""

    (let [[candidates (+ (get entry "content" [])
                         (get entry "summary_detail" []))]]

        (for [c candidates]
            (if (in "html" (get c "type" ""))
                (get c "value")))
        (get (get candidates 0) "value" "")))
