context("Replicate results from validated sources")

test_that("Replicate Germán Rodríguez 2015, Ex. 1, Phillippines age distrubtion", {
  dat <- read.csv("../data/phpop1990.csv")
  expect_equal(as.numeric(myers(dat$age, dat$freq, bin_start = 0, bin_size = 90)),
               1.927535,
               tolerance = 1e-7)
})

test_that("Replicate Lee & Zhang 2013, Table OA2.1", {
  dat <- read.csv("../data/lz-oa2.1.csv")
  expect_equal(as.numeric(myers(dat$age, dat$freq, bin_start = 10, bin_size = 60)),
               17.911,
               tolerance = 1e-4) # higher rounding error
})
