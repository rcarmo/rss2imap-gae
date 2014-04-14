(import os sys logging bottle)
(import [bottle [DEBUG default_app run route]])

(setv DEBUG true)
(def log (.getLogger logging))
(def app (default_app))

(route "/" ["GET"]
    (fn []
        (.debug log "Hy there!")
        "Hy there!"))

(apply run []
    {"app"    app
     "server" "gae"})
