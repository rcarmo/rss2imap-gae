(import bottle [route abort request response])
(import feeds [get-all-feeds])

(route "/feeds" ["GET"]
    (fn []
        (get-all-feeds))

(route "/feeds/new" ["POST"]
    (fn []
        (let [[url (get (.forms request) "url" nil)]]
        ; TODO: urlparse it and abort if incorrect
        
    )))

