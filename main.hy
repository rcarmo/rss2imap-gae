(import os sys [logging [getLogger DEBUG]] bottle)
(import [bottle [default_app run route view template]])
(import routes)

(setv bottle.DEBUG true)
(setv log (getLogger))
(.setLevel log DEBUG)

(apply run []
    {"app"    default_app
     "server" "gae"})
