(import
    [google.appengine.ext.ndb
        [BaseModel LinkProperty StringProperty KeyProperty DateTimeProperty]])

(defclass Feed [BaseModel]
    [[url           (kwapply (StringProperty) {"required" true})]
     [last-checked  (DateTimeProperty)]
     [folder        (StringProperty)]])

(defclass Account [BaseModel]
    [[username (kwapply (StringProperty) {"required" true})]
     [password (kwapply (StringProperty) {"required" true})]
     [server   (kwapply (StringProperty) {"required" true})]])

(defclass Subscription [BaseModel]
    [[account  (KeyProperty Account)]
     [feed     (KeyProperty Feed)]
     [items    (kwapply (KeyProperty Item)
                        {"repeated" true "indexed" false})]])

(defclass Item [BaseModel]
    [[subscription (KeyProperty Account)]
     [data         (kwapply (StringProperty) {"indexed" false}]])
