(import os sys [logging [getLogger]] feedparser)
(require hy.contrib.loop)

(apply logging.basicConfig [] {"format" "%(asctime)s %(funcName)s %(levelname)s %(message)s"})
(setv log (getLogger))

(defn fetch-single-feed [url]
    ; returns all entries for this feed
    (.debug log url)
    (try
        (let [[entries (get (.parse feedparser url) "entries")]]
            (for [e entries]
                (yield e)))
        (catch [e Exception]
            (.error log (% "Error getting %s: %s" url e)))))

(def feed-urls ["http://the.taoofmac.com/rss" "http://daringfireball.net/index.xml"])

(defn get-feed-urls []
    (let [[feeds (.query Feed)]]
        (for [f feeds]
            (yield (. f url)))))

(defn store-items [items]
    (for [i items]
        (.debug log i)))

(defn deliver [to-account]
    (let [[subscriptions (.query Subscription (== (.key to-account) (.account Subscription)))]]
        (.debug log subscriptions)))

(defn fetch-all []
    (->> feed-urls
        (map fetch-single-feed)
        (map store-items)))
