
/**
 * search for the typed text within the tables
 * row content
 * @param table
 * @param term
 * @returns
 */
function fuzzySearch (table, term) {
  var found = []
  Array.from(table.tBodies).forEach(function(tbody) {
    Array.from(tbody.rows).forEach(function(row, rowIndex) {
      var text = row.textContent.toLowerCase()
      if (text.indexOf(term) > -1) found.push(rowIndex)
    })
  })
  return found
}

/**
 * Filter the visible table rows baed on if they match
 * the currnt criteria (plain text search)
 * @param table
 * @param fuzzy
 */
function filterDisplay(table, fuzzy) {
  var found = []
  if (fuzzy.length > 0){
    var results = fuzzySearch(table, fuzzy)
    for(var i=0; i < results.length; i++) found.push(results[i])
  } else Array.from(table.querySelectorAll('tbody tr')).forEach( function (r, i) { found.push(i) } )

  Array.from(table.tBodies).forEach(function(tbody) {
    Array.from(tbody.rows).forEach(function(r, i) {
      var enable = found.includes(i)
      r.style.display = enable ? 'table-row' : 'none'
    })
  })
}

/**
 * Inject a form before the start of the table
 * which acts as a free hand text search
 * @param table
 * @param tableIndex
 */
function search (table, tableIndex) {
  var timer = 0;
  table.insertAdjacentHTML('beforebegin', '<form class="filter-'+tableIndex+' filter-search filter-search-'+tableIndex+'"><label>Search packages:</label><input type="text" class="govuk-input govuk-!-margin-bottom-4"></form>')
  var ele = document.querySelector('.filter-search-'+tableIndex+' input')

  ele.addEventListener("input", function(e) {
    clearTimeout(timer)
    timer = setTimeout(function() { filterDisplay(table, ele.value.toLowerCase() ) }, 500)
  })
}


/**
 * Applies the filters on each table with the set class
 */
function filters() {
  var tables = Array.from( document.querySelectorAll('table.filter') )
  tables.forEach(function(table, tableIndex) {
    search(table, tableIndex)
  })
}

document.addEventListener("DOMContentLoaded", filters)
