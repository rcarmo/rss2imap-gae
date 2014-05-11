var app = {};

app.FeedList = function() {
    return m.request({method: "GET", url: "/api/feeds"});
}

app.controller = function() {
    this.feeds = app.FeedList();
}

app.view = function(ctrl) {
    return ctrl.feeds().map(function(feed) {
        return m("tr", [
            m("td", [m("a", {href: feed.url}, feed.url)]),
            m("td", [feed.last_checked])
        ])
    })
}

m.module(document.getElementById("feedlist"), app);
