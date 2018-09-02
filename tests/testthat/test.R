context('ranking')

test_that("ranking returns a tibble with study progammes", {
  expect_equal(nrow(ranking('socjologia stosowana')), 4)
  expect_equal(nrow(ranking('no_study')), 0)
  expect_equal(sum(ranking('socjologia')$wynagrodzenie_brutto), 47864.5)
  expect_match(ranking('architektura')$kierunek_studiow, "architektura")
  expect_error(ranking(2), "Name of the study programme (kierunek) should be a character value", fixed = TRUE)
})


context('liczba_absolwentow')

test_that("liczba_absolwentow returns a tibble with number of graduates", {
  expect_is(liczba_absolwentow('socjologia'), "tbl")
  expect_error(liczba_absolwentow(2), "Name of the study programme (kierunek) should be a character value", fixed = TRUE)
  })


context('wykres_zarobki_bezrobocie')

test_that("wykres_zarobki_bezrobocie returns a scatter plot", {
  expect_is(wykres_zarobki_bezrobocie('socjologia'), "plotly")
  expect_error(wykres_zarobki_bezrobocie(2), "Name of the study programme (kierunek) should be a character value", fixed = TRUE)
})


context('wyszukaj_studia_tabela')

test_that("wyszukaj_studia_tabela returns a tibble with study programmes", {
  expect_is(wyszukaj_studia_tabela('socjologia'), "tbl")
  expect_error(wyszukaj_studia_tabela(2), "Name of the study programme (kierunek) should be a character value", fixed = TRUE)
  expect_equal(nrow(wyszukaj_studia_tabela('architektura', min_wynagrodzenie_brutto = 6000)),1)
})


context('wyszukaj_studia_mapa')

test_that("wyszukaj_studia_mapa returns a maps with study programmes", {
  expect_is(wyszukaj_studia_mapa('socjologia'), "leaflet")
  expect_error(wyszukaj_studia_mapa(2), "Name of the study programme (kierunek) should be a character value", fixed = TRUE)
})
