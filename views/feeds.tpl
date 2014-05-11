<form class="ink-form" action="/api/feeds" method="post">
    <div class="control-group column-group horizontal-gutters">
        <label for="url" class="all-10 align-right">URL</label>
        <div class="control append-button">
            <input type="text" name="url">
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
  </tbody>
</table>


% rebase('layout.tpl', title=title)
