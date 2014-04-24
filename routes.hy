(import
    os sys
    [logging    [getLogger]]
    [bottle     [route view template request]]
    [decorators [jsonp cache-results timed]]
    [feeds      [get-all-feeds add-feed]])

(setv log (getLogger))

(route "/api/feeds" ["POST"]
    (fn [] 
        (let [[url (.get request.forms "url" nil)]]
            (if url
                (add-feed url)))))


(with-decorator timed jsonp (cache-results 30)
    (route "/api/feeds" ["GET"]
        (fn []
            (list-comp
                {"url"          (. x url)
                 "last_checked" (. x last-checked)} [x (get-all-feeds)]))))


(with-decorator timed (cache-results 10) (view "feeds")
    (route "/" ["GET"]
        (fn []
            (.debug log "Hy there!")
            {"title" "Feeds"})))

