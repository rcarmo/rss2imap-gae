
<form class="ink-form" action="/feeds/add" method="post">
    <div class="control-group column-group horizontal-gutters">
        <label for="url" class="all-10 align-right">URL</label>
        <div class="control append-button">
            <input type="text" id="url">
            <button class="ink-button">Add</button>
            <p class="tip">Enter a valid feed URL</p>
        </div>
    </div>
</form>

<table class="ink-table alternating">
  <thead>
    <tr>
      <th>Feed URL</th>
      <th>Last Checked</th>
    </tr>
  </thead>
  <tbody id="feedlist">
% for f in feeds:
    <tr>
      <td>{{f.get("url")}}</td>
      <td>{{f.get("updated", "Never")}}</td>
    </tr>
% end
  </tbody>
</table>

<script>
var app = {};

app.FeedList = function() {
    return m.request({method: "GET", url: "/api/feeds"});
}

app.controller = function() {
    this.feeds = app.FeedList();
}

app.view = function(ctrl) {
    return ctrl.feeds().map(function(feed) {
        return m("tr",
            m("td", m("a", {href: feed.url})),
            m("td", feed.updated));
    })
}

m.module(document.getElementById("feedlist"), app);
</script>

% rebase('layout.tpl', title=title)
