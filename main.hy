(import os sys logging)
(import [bottle [run route])

(def log (.getLogger logging))

(route "/" ["GET"]
    (.debug log "Hy there!")
    (fn [] "Hy there!"))

(def app (.default_app bottle))

(setv (.DEBUG bottle) true)

(kwapply (run)
    {"app"    app
     "server" "gae"})
