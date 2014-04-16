(import os sys [logging [getLogger DEBUG]] bottle)
(import [bottle [default_app run route view template]])

(setv bottle.DEBUG true)
(setv log (getLogger))
(.setLevel log DEBUG)

(import routes)

(def app (default_app))

(with-decorator (view "feeds")
    (route "/" ["GET"]
        (fn []
            (.debug log "Hy there!")
            {"title" "Feeds"
             "feeds" [{"url" "test"}]})))

(apply run []
    {"app"    app
     "server" "gae"})
