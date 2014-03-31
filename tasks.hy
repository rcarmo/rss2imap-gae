


(defn fetch-one [url]
    (try
        (let [[result (.parse feedparser url)]]
            
        ))
        (catch [e Exception]
            (.error log (% "Error getting %s: %s" url e

(defn deliver [to-account]
    (let [[subscriptions (.query Subscription (== (.key to-account) (.account Subscription)))]]
        (.debug log subscriptions)))
