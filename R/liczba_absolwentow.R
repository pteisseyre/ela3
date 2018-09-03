#' liczba_absolwentow returns a tibble with number of graduates
#'
#' 'liczba_absolwentow()' returns a tibble with number of graduates in 2016
#' grouped by study progammes
#'
#' @param kierunek a character value, name of study programe, i.e. 'socjologia'
#' @param stopien a vector of character values: '1' - studia pierwszego stopnia,
#'   undergraduate education, '2' - studia drugiego stopnia, complementary
#'   Master's studies, 'JM' - studia jednolite magisterskie, 5-year Master's
#'   studies
#' @param liczba_kierunkow a numeric value, use it to limit number of study
#'   programmes to display, default value 10
#'
#' @return a tibble with following columns: study programme, study programme,
#'   uczelnia, wydzial and number of graduates in 2016
#' @export
#'
#' @examples
#' liczba_absolwentow('ekonomia', stopien = c('1', '2'))
liczba_absolwentow <- function(kierunek, stopien = c('1', '2', 'JM'), liczba_kierunkow = 10){

  # Setting variables to null
  kierunek_studiow <- stopien_studiow <- uczelnia <- wydzial <- head <- NULL

  # Assert that the name of study programme is a character value
  assertthat::assert_that(is.character(kierunek), msg = "Name of the study programme (kierunek) should be a character value")

  # Stop if stopien is not one of the values: '1', '2', 'JM'
  if (!('1' %in%  stopien | '2' %in% stopien | '3' %in% stopien)) {
    stop("stopien must be either '1', '2', 'JM'")
  }

  result <- dane %>%
    dplyr::filter(grepl(tolower(kierunek), kierunek_studiow),
           stopien_studiow %in% stopien) %>%
    dplyr::select(kierunek_studiow, uczelnia, wydzial, liczba_absolwentow) %>%
    head(liczba_kierunkow) %>%
    dplyr::as_tibble()



  return(result)
}
