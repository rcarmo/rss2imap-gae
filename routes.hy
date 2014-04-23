(import
    os sys
    [logging    [getLogger]]
    [bottle     [route view template]]
    [decorators [jsonp]]
    [feeds      [get-all-feeds]])

(setv log (getLogger))

(with-decorator jsonp
    (route "/api/feeds" ["GET"]
        (fn []
            (list-comp x [x (get-all-feeds)]))))

(with-decorator (view "feeds")
    (route "/" ["GET"]
        (fn []
            (.debug log "Hy there!")
            {"title" "Feeds"
             "feeds" (get-all-feeds)})))

