
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

<table class="ink-table">
  <thead>
    <tr>
      <th>Feed URL</th>
      <th>Last Checked</th>
    </tr>
  </thead>
  <tbody>
% for f in feeds:
    <tr>
      <td>{{f.get("url")}}</td>
      <td>{{f.get("updated", "Never")}}</td>
    </tr>
% end
  </tbody>
</table>


% rebase('layout.tpl', title=title)
