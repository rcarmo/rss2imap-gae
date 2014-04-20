(import os sys [logging [getLogger DEBUG]] bottle)
(import [bottle [default_app run route view template]])

(setv bottle.DEBUG true)
(setv log (getLogger))
(.setLevel log DEBUG)

(def app (default_app)) 

(import routes)

(apply run []
    {"app"    app
     "server" "gae"})
