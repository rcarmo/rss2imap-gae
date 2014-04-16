(import
    [google.appengine.ext.ndb
        [Model StringProperty KeyProperty DateTimeProperty]])


(defclass Feed [Model]
    [[url           (apply StringProperty [] {"required" true})]
     [last-checked  (DateTimeProperty)]
     [folder        (StringProperty)]])


(defclass Account [Model]
    [[username (apply StringProperty [] {"required" true})]
     [password (apply StringProperty [] {"required" true})]
     [server   (apply StringProperty [] {"required" true})]])


(defclass Subscription [Model]
    [[account  (KeyProperty Account)]
     [feed     (KeyProperty Feed)]
     [items    (apply (KeyProperty Item) []
                      {"repeated" true "indexed" false})]])

(defclass Item [Model]
    [[subscription (KeyProperty Account)]
     [data         (apply StringProperty [] {"indexed" false})]])
