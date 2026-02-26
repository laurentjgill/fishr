test_that("cpue calculates simple ratio correctly", {
  expect_equal_numbers(cpue(catch = 100, effort = 10), 10)
  expect_equal_numbers(cpue(catch = 50, effort = 2), 25)
})

test_that("cpue handles vectors of data", {
  catches <- c(100, 200, 400)
  efforts <- c(10, 10, 10)
  expected_results <- c(10, 20, 40)

  expect_equal_numbers(cpue(catches, efforts), expected_results)
})

test_that("cpue returns numeric values", {
  expect_type(cpue(100, 10), "double")
})



test_that("gear factor standardization scales correctly", {
  expect_equal_numbers(cpue(catch = 100, effort = 10, gear_factor = 0.5), 5)

  expect_equal(
    cpue(catch = 100, effort = 10),
    cpue(catch = 100, effort = 10, gear_factor = 1)
  )
})


test_that("cpue handles missing data", {
  expect_true(is.na(cpue(NA_real_, 10)))
  expect_true(is.na(cpue(100, NA_real_)))
})

test_that("cpue works with generated data", {
  data <- generate_fishing_data(n = 5)
  result <- cpue(data$catch, data$effort)

  expect_equal_numbers(
    result,
    c(34.053, 9.065, 19.239, 135.640, 6.372),
    tolerance = 1e-2
  )
})

test_that("cpue matches reference data", {
  result <- cpue(reference_data$catch, reference_data$effort)

  expect_equal_numbers(result, reference_data$expected_cpue)
})

#test messaging
test_that("cpue shows a message", {
  expect_message(
    cpue(c(100, 200), c(10, 20), verbose = TRUE),
    "Processing 2 records"
  )
})


#snapshot tests
#errors
test_that("cpue errors when input is not numeric", {
  expect_snapshot(
    cpue("five", 10),
    error = TRUE
  )
})

#warnings
test_that("cpue warns when cathc and effort lengths differ", {
  #if cpue length differs, it will just recycle the shorter vector to make it longer and throw a warning (no error)
  expect_snapshot(
    cpue(c(100, 20, 30), c(20, 5))
  )
  expect_no_warning(cpue(100, 10))
})

test_that("cpue uses verbosity when global options is set to TRUE", {
  withr::local_options(fishr.verbose = TRUE)
  expect_snapshot(cpue(10, 10))
})

test_that("cpue is not vrbose when option is FALSE", {
  withr::local_options(fishr.verbose = FALSE)
  expect_silent(cpue(10, 10))
})

#Testing S3 class
test_that("cpue() returns a cpue_result object", {
  result <- cpue(c(100, 200), c(10, 20))
  expect_s3_class(result, "cpue_results")
})

test_that("print.cpue_result displays expected output", {
  result <- cpue(c(100, 200, 300), c(10, 20, 15))
  expect_snapshot(print(result))
})
