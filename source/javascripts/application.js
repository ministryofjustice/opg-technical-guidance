//= require govuk_tech_docs

/**
 * search for the typed text within the tables
 * row content
 * @param table
 * @param term
 * @returns
 */
const fuzzySearch = (table, term) => {
  let found = []
  Array.from(table.tBodies).forEach(tbody => {
    Array.from(tbody.rows).forEach((row, rowIndex) => {
      const text = row.textContent.toLowerCase()
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
const filterDisplay = async (table, fuzzy) => {
  let found = []
  if (fuzzy.length > 0){
    found.push(...fuzzySearch(table, fuzzy))
  } else Array.from(table.querySelectorAll('tbody tr')).forEach( (r, i) => found.push(i) )

  Array.from(table.tBodies).forEach(tbody => {
    Array.from(tbody.rows).forEach((r, i) => {
      const enable = found.includes(i)
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
const search = async (table, tableIndex) => {
  let timer = 0;
  table.insertAdjacentHTML('beforebegin', `
  <form class="filter-${tableIndex} filter-search filter-search-${tableIndex}">
    <label>Search: <input type='text'></label>
  </form>`)
  let ele = document.querySelector(`.filter-search-${tableIndex} input`)

  ele.addEventListener("input", (e) => {
    clearTimeout(timer)
    timer = setTimeout(() => filterDisplay(table, ele.value.toLowerCase() ), 500)
  })
}

/**
 * Applies the filters on each table with the set class
 */
const filters = async() => {
  const tables = Array.from( document.querySelectorAll('.filter') )
  tables.forEach((table, tableIndex) => {
    search(table, tableIndex)
  })
}


document.addEventListener("DOMContentLoaded", filters)
