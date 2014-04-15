(import os sys logging [time [mktime time]])

(setv log (.getLogger logging))

(defn get-title [entry]
    (get entry "title" "Untitled"))

(defn get-entry-id [entry]
    (get entry "guid"))

(defn get-entry-tags [entry]
    ; grabs post tags (if any)
    (let [[tags (get entry "tags" [])]]
        (.join ',' (set (list-comp (get tag term) [tag tags])))))

(defn get-entry-author [entry]
    (get (get entry "author_detail" {"name" None}) "name" None))
    
(defn get-entry-timestamp [entry]
    """Select the best timestamp for an entry"""
    (for [header ["modified" "issued" "created"]]
        (let [[when (get entry (+ header "_parsed") None)]]
            (if when
                (mktime when))))
    (time))
