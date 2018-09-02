#' Dataset about graduates in 2016 from universities in Poland
#'
#' A dataset containing indicators of almost 9609 graduates
#'
#' @format A data frame with 9609 rows and 12 variables: \describe{
#'   \item{kierunek_studiow}{study programme}
#'   \item{wynagrodzenie_brutto}{avarage gross income in PLN in the first year
#'   after graduation}
#'   \item{wynagrodzenie_wzgledne}{relative salary, proportion
#'   of avarage income in the first year after graduation to the avarage incomes
#'   in powiats (counties) where graduates live}
#'   \item{ryzyko_bezrobocia}{% of months in the first year after graduation
#'   when graduates were registered as unempolyed}
#'   \item{bezrobocie_wzgledne}{proportion of unemployment among graduates to
#'   the unemployment rate in the powiats (counties) where graduates live}
#'   \item{czas_poszukiwania_pracy}{avarage numeber of months
#'   between graduation and begin of first employment in the first year after
#'   emplyment}
#'   \item{stopien_studiow}{study level (possible values are: '1' -
#'   studia pierwszego stopnia, undergraduate education, '2' - studia drugiego
#'   stopnia, complementary Master's studies, 'JM' - studia jednolite
#'   magisterskie, 5-year Master's studies)}
#'   \item{uczelnia}{university name}
#'   \item{wydzial}{faculty name}
#'   \item{liczba_absolwentow}{number of graduates in 2016}
#'   \item{lat}{coordinates of universities, latitude}
#'   \item{lon}{coordinates of universities, longitude}}
#' @source \url{http://ela.nauka.gov.pl/}
"dane"
