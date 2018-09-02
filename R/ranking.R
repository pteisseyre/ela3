#' ranking returns a tibble with study progammes
#'
#' 'ranking()' returns a tibble with study progammes sorted according to
#' selected indicator (wskaznik)
#'
#' @param kierunek a character value, name of study programe, i.e. 'socjologia'
#' @param wskaznik a character value or a vector of character values, allowed
#'   values: "wynagrodzenie_brutto", "wynagrodzenie_wzgledne",
#'   "ryzyko_bezrobocia", "bezrobocie_wzgledne", "czas_poszukiwania_pracy"
#' @param stopien a vector of character values: '1' - studia pierwszego stopnia,
#'   undergraduate education, '2' - studia drugiego stopnia, complementary
#'   Master's studies, 'JM' - studia jednolite magisterskie, 5-year Master's
#'   studies
#' @param liczba_kierunkow a numeric value, use it to limit number of study
#'   programmes to display, default value 10
#' @param kolejnosc_malejaca a boolean, whether to display results sorted
#'   according to selected wskaznik (indicator) in descending order, default
#'   TRUE, sroting relates to selected indicator, wskaznik
#'
#' @return a tibble with following columns: study programme, uczelnia, wydzial,
#'   selected wskaznik(indicator), study level
#' @import magrittr
#'
#' @export
#'
#' @examples
#' ranking('socjologia')
ranking <- function(kierunek, wskaznik = 'wynagrodzenie_brutto', stopien = c('1', '2', 'JM'), liczba_kierunkow = 10, kolejnosc_malejaca = TRUE){

  data(dane)

  # Assert that the name of study programme is a character value
  assertthat::assert_that(is.character(kierunek), msg = "Name of the study programme (kierunek) should be a character value")

  result <- dane %>%
    dplyr::filter(grepl(tolower(kierunek), kierunek_studiow),
           stopien_studiow %in% stopien) %>%
    dplyr::select(kierunek_studiow, uczelnia, wydzial, wskaznik, stopien_studiow) %>%
    dplyr::filter_(lazyeval::interp(~!is.na(value), value = as.name(wskaznik)))


  if (kolejnosc_malejaca == TRUE) {

    result %>%
      dplyr::arrange_(lazyeval::interp(~dplyr::desc(value), value = as.name(wskaznik))) %>%
      head(liczba_kierunkow) %>%
      dplyr::as_tibble()

  } else {

    result %>%
      dplyr::arrange_(lazyeval::interp(~value, value = as.name(wskaznik))) %>%
      head(liczba_kierunkow) %>%
      dplyr::as_tibble()

  }

}
