#' wyszukaj_studia_tabela returns a tibble with study programmes
#'
#' wyszukaj_studia_tabela returns a tibble with study programmes that meet
#' selected criteria: graduates with avarage incomes in the first year after
#' graduation equal or higher than min_wynagrodzenie_brutto and avarage time
#' between graduation and begin of first employment equal or lower than
#' max_czas_poszukiwania_pracy
#'
#' @param kierunek a character value, name of study programe, i.e. 'socjologia'
#' @param stopien a vector of character values: '1' - studia pierwszego stopnia,
#'   undergraduate education, '2' - studia drugiego stopnia, complementary
#'   Master's studies, 'JM' - studia jednolite magisterskie, 5-year Master's
#'   studies
#' @param min_wynagrodzenie_brutto a numeric value in PLN, avarage incomes in
#'   the first year after graduation
#' @param max_czas_poszukiwania_pracy a numeric value in months, avarage time
#'   between graduation and begin of first employment equal or lower than
#'   max_czas_poszukiwania_pracy
#'
#' @return a tibble that contains following columns: study programme, university
#'   name, faculty name, avarage income of graduates in the first year after
#'   graduation in PLN, avarage time from graduation to begin of first
#'   employment in months
#' @export
#'
#' @examples
#' wyszukaj_studia_tabela('socjologia', stopien = c('1', '2'),
#' min_wynagrodzenie_brutto = 3000, max_czas_poszukiwania_pracy = 3)
wyszukaj_studia_tabela <- function(kierunek, stopien = c('1', '2', 'JM'),
                                   min_wynagrodzenie_brutto = NULL,
                                   max_czas_poszukiwania_pracy = NULL) {

  # Assert that the name of study programme is a character value
  assertthat::assert_that(is.character(kierunek), msg = 'Name of the study programme (kierunek) should be a character value')

  result <- dane %>%
    dplyr::filter(grepl(tolower(kierunek), kierunek_studiow),
           stopien_studiow %in% stopien) %>%
    dplyr::select(kierunek_studiow, uczelnia, wydzial, wynagrodzenie_brutto, czas_poszukiwania_pracy) %>%
    dplyr::as_tibble()

  if (!is.null(min_wynagrodzenie_brutto)) {

    result <- result %>%
      dplyr::filter(wynagrodzenie_brutto >= min_wynagrodzenie_brutto)

  }


  if (!is.null(max_czas_poszukiwania_pracy)) {

    result <- result %>%
      dplyr::filter(czas_poszukiwania_pracy <= max_czas_poszukiwania_pracy)

  }

  return(result)

}
