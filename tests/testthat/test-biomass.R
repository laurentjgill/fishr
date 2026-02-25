test_that("the biomass index provides correct output", {
  expect_equal(biomass_index(5, 10), 50)
  expect_equal(biomass_index(20, 10), 200)
})

#vectors
test_that("biomass index handles vectors of data", {
  cpue <- c(5, 10, 20)
  area_swept <- c(2, 3, 1)
  expected_results <- c(10, 30, 20)

  expect_equal(biomass_index(cpue, area_swept), expected_results )
})

#invalid input
test_that("error on invalid input", {
  expect_snapshot(biomass_index("ten", 5),
                  error = TRUE)
})
