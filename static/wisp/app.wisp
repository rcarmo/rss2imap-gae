(def app {})

(defn app.FeedList []
   (.request m {:method "GET"
                :url "/api/feeds"}))

(defn app.controller []
    (set! this.feeds (app.FeedList)))


(defn app.view []
  (.map (ctrl.feeds) 
        (fn [feed]
          (m "tr" [
            (m "td" [(m "a" {:href feed.url} feed.url)])
            (m "td" [feed.last_checked])
            ]))))

(.module m (.getElementById document "feedlist") app)

(.log console "ready")
