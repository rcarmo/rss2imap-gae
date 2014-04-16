(import os sys logging bottle)
(import [bottle [DEBUG default_app run route view template]])

(setv bottle.DEBUG true)
(def log (.getLogger logging))
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
