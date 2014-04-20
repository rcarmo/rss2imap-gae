(import
    os sys
    [logging [getLogger]]
    [bottle  [route view template]]
    [feeds   [get-all-feeds]])

(setv log (getLogger))

(with-decorator (view "feeds")
    (route "/" ["GET"]
        (fn []
            (.debug log "Hy there!")
            {"title" "Feeds"
             "feeds" (get-all-feeds)})))

