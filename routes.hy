(import
    os sys
    [logging [getLogger]]
    [bottle [route abort request response]]
    [feeds [get-all-feeds]])

(setv log (getLogger))

(route "/feeds" ["GET"]
    (fn []
        (get-all-feeds)))

(route "/feeds/new" ["POST"]
    (fn []
        (let [[url (get (.forms request) "url" nil)]]
        ; TODO: urlparse it and abort if incorrect
        (.log debug url)
        )))

