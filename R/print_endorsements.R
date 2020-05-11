#' Output endorsements from an Rmarkdown file
#'
#' Processes endorsements in the YAML header of an RMarkdown file and outputs them. Designed for use in distill templates
#' @export
print_endorsements = function() {
  endorsements = rmarkdown::metadata$endorsements
  repo_url = rmarkdown::metadata$repository_url

  if (length(endorsements) == 0) {
    cat('<p><small>This paper has not yet received any endorsements</small></p><hr>')
    return()
  }

  s = if (length(endorsements) > 1) "s" else ""
  cat('<p><small>This paper has <a href="#endorsements">', length(endorsements), ' endorsement', s, '</a></small></p><hr>', sep = '')

  cat('<h1 id="endorsements" class="appendix">Endorsements</h1>\n')
  for (e in endorsements) {
    name = if (is.null(e$name)) "" else e$name
    link = if (is.null(e$url)) name else paste0('<a href="', e$url, '">', name, '</a>')
    date = if (is.null(e$date)) "" else paste0('on ', e$date, '')
    version = if (is.null(repo_url) || is.null(e$commit)) "" else paste0(
      '| version <a href="', repo_url, '/tree/', e$commit, '">', substr(e$commit, 1, 7), '</a> | ',
      '<a href="', repo_url, '/compare/', e$commit, '...master', '">compare</a>'
    )
    cat('<p>', link, date, version, "</p>")
  }
}
