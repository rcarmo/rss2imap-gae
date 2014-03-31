(import
    [google.appengine.ext.ndb
        [Model LinkProperty StringProperty KeyProperty DateTimeProperty]])


(defclass Feed [Model]
    [[url           (kwapply (StringProperty) {"required" true})]
     [last-checked  (DateTimeProperty)]
     [folder        (StringProperty)]])


(defclass Account [Model]
    [[username (kwapply (StringProperty) {"required" true})]
     [password (kwapply (StringProperty) {"required" true})]
     [server   (kwapply (StringProperty) {"required" true})]])


(defclass Subscription [Model]
    [[account  (KeyProperty Account)]
     [feed     (KeyProperty Feed)]
     [items    (kwapply (KeyProperty Item)
                        {"repeated" true "indexed" false})]])

(defclass Item [Model]
    [[subscription (KeyProperty Account)]
     [data         (kwapply (StringProperty) {"indexed" false}]])
