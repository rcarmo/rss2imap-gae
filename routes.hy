(import
    os sys
    [logging    [getLogger]]
    [bottle     [route view template request]]
    [decorators [jsonp]]
    [feeds      [get-all-feeds add-feed]])

(setv log (getLogger))

(route "/api/feeds" ["POST"]
    (fn [] 
        (let [[url (.get request.forms "url" nil)]]
            (if url
                (add-feed url)))))


(with-decorator jsonp
    (route "/api/feeds" ["GET"]
        (fn []
            (list-comp
                {"url"          (. x url)
                 "last_checked" (. x last-checked)} [x (get-all-feeds)]))))


(with-decorator (view "feeds")
    (route "/" ["GET"]
        (fn []
            (.debug log "Hy there!")
            {"title" "Feeds"})))

