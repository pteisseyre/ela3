#' wykres_zarobki_bezrobocie returns a scatter plot
#'
#' 'wykres_zarobki_bezrobocie()' returns a scatter plot with relative indicator of
#' income on Y-axis and relative indicator of unemployment on X-axis for
#' selected study programme and study level, each point represents a study
#' programme
#'
#' @param kierunek a character value, name of study programe, i.e. 'socjologia'
#' @param stopien a vector of character values: '1' - studia pierwszego stopnia,
#'   undergraduate education, '2' - studia drugiego stopnia, complementary
#'   Master's studies, 'JM' - studia jednolite magisterskie, 5-year Master's
#'   studies
#'
#' @return a scatter plot
#' @export
#'
#' @examples
#' wykres_zarobki_bezrobocie('socjologia', stopien = c('1', '2'))
wykres_zarobki_bezrobocie <- function(kierunek, stopien = c('1', '2', 'JM')) {

  # Assert that the name of study programme is a character value
  assertthat::assert_that(is.character(kierunek), msg = 'Name of the study programme (kierunek) should be a character value')

  plot_data <- dane %>%
    dplyr::filter(grepl(tolower(kierunek), kierunek_studiow),
           stopien_studiow %in% stopien) %>%
    dplyr::select(-c(2, 4, 6, 10:12)) %>%
    dplyr::filter(!is.na(wynagrodzenie_wzgledne) & !is.na(bezrobocie_wzgledne))


  plotly::plot_ly(data = plot_data, x = ~bezrobocie_wzgledne, y= ~wynagrodzenie_wzgledne, type = 'scatter', mode = 'markers',
          marker = list(size = 10,
                        color = 'rgba(255, 182, 193, .9)',
                        line = list(color = 'rgba(152, 0, 0, .8)',
                                    width = 2)),
          text = ~paste('<b>Study programme:</b>', kierunek, '<br><b>University: </b>', uczelnia, '<br><b>Faculty: </b>', wydzial)) %>%
    plotly::layout(title = 'Relative income vs. relative unemployment among graduates',
           yaxis = list(title = 'indicator of relative incomes', zeroline = FALSE),
           xaxis = list(title = 'indicator of relative unemployment', zeroline = FALSE)) %>%
    plotly::config(displayModeBar = FALSE)

}
