
(defclass Feed [BaseModel]
    [[url    (kwapply (db.LinkProperty) {"required" true})]
     [folder (db.StringProperty)]])

(defclass Account [BaseModel]
    [[username (kwapply (db.StringProperty) {"required" true})]
     [password (kwapply (db.StringProperty) {"required" true})]
     [server   (kwapply (db.StringProperty) {"required" true})]])
