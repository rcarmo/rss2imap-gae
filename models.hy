(import
    [google.appengine.ext.ndb [Model StringProperty DateTimeProperty KeyProperty]]
)


(defclass Feed [Model]
    [[url           (apply StringProperty [] {"required" true})]
     [last-checked  (DateTimeProperty)]])


(defclass Account [Model]
    [[username (apply StringProperty [] {"required" true})]
     [password (apply StringProperty [] {"required" true})]
     [server   (apply StringProperty [] {"required" true})]])


(defclass Item [Model]
    [[subscription (KeyProperty Account)]
     [data         (apply StringProperty [] {"indexed" false})]])


(defclass Subscription [Model]
    [[account  (KeyProperty Account)]
     [feed     (KeyProperty Feed)]
     [folder   (StringProperty)]
     [items    (apply KeyProperty [Item]
                      {"repeated" true "indexed" false})]])

