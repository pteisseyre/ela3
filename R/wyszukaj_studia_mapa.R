#' wyszukaj_studia_mapa returns a leaflet map
#'
#' 'wyszukaj_studia_mapa()' returns a leaflet map of Poland with study
#' programmes that meet selected criteria: graduates with avarage incomes in the
#' first year after graduation equal or higher than min_wynagrodzenie_brutto and
#' avarage time between graduation and begin of first employment equal or lower
#' than max_czas_poszukiwania_pracy
#'
#' @param kierunek a character value, name of study programe, i.e. 'socjologia'
#' @param stopien a vector of character values: '1' - studia pierwszego stopnia,
#'   undergraduate education, '2' - studia drugiego stopnia, complementary
#'   Master's studies, 'JM' - studia jednolite magisterskie, 5-year Master's
#'   studies
#' @param min_wynagrodzenie_brutto a numeric value in PLN, avarage incomes in the first
#'   year after graduation
#' @param max_czas_poszukiwania_pracy a numeric value in months, avarage time between
#'   graduation and begin of first employment equal or lower than
#'   max_czas_poszukiwania_pracy
#'
#' @return a leaflet map with study programmes, the markers display following
#'   informations: study programme, university name, faculty name, avarage
#'   income of graduates in the first year after graduation in PLN, avarage time
#'   from graduation to begin of first employment in months
#' @export
#'
#' @examples
#' wyszukaj_studia_mapa('socjologia', stopien = c('1', '2'),
#' min_wynagrodzenie_brutto = 3000, max_czas_poszukiwania_pracy = 3)
wyszukaj_studia_mapa <- function(kierunek, stopien = c('1', '2', 'JM'),
                                 min_wynagrodzenie_brutto = NULL,
                                 max_czas_poszukiwania_pracy = NULL) {

  data(dane)

  # Assert that the name of study programme is a character value
  assertthat::assert_that(is.character(kierunek), msg = 'Name of the study programme (kierunek) should be a character value')

  result <- dane %>%
    dplyr::filter(grepl(tolower(kierunek), kierunek_studiow),
           stopien_studiow %in% stopien) %>%
    dplyr::select(kierunek_studiow, uczelnia, wydzial, wynagrodzenie_brutto, czas_poszukiwania_pracy, lat, lon) %>%
    dplyr::as_tibble()

  if (!is.null(min_wynagrodzenie_brutto)) {

    result <- result %>%
      dplyr::filter(wynagrodzenie_brutto >= min_wynagrodzenie_brutto)

  }


  if (!is.null(max_czas_poszukiwania_pracy)) {

    result <- result %>%
      dplyr::filter(czas_poszukiwania_pracy <= max_czas_poszukiwania_pracy)

  }


  map_labels <- lapply(seq(nrow(result)), function(i) {
    paste0('<strong>', result[i, 'kierunek_studiow'], '</strong>', '<br>',
           result[i, 'uczelnia'], '<br>',
           result[i, 'wydzial'], '<br>',
           '<strong>', 'wynagrodzenie brutto: ', '</strong>', result[i, 'wynagrodzenie_brutto'], '<br>',
           '<strong>', 'czas poszukiwania pracy: ', '</strong>', result[i, 'czas_poszukiwania_pracy'])
  })



  map <- leaflet::leaflet(data = result) %>%
    leaflet::addTiles() %>%
    leaflet::addMarkers(~lon, ~lat,
               label = lapply(map_labels, htmltools::HTML),
               labelOptions = leaflet::labelOptions(noHide = F,
                                           style = list(
                                             "color" = "#303030",
                                             "box-shadow" = "3px 3px rgba(0,0,0,0.25)",
                                             "font-size" = "10px",
                                             "font-style" = "normal",
                                             "border-color" = "#F7F7F7"
                                           )),
               clusterOptions = leaflet::markerClusterOptions())



  return(map)

}
