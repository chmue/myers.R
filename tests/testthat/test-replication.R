context("Replicate results from validated sources")

test_that("Replicate TODO fill in name/website", {
  dat <- read.csv("../data/phpop1990.csv")
  expect_equal(myers_n(dat$age, dat$freq), 1.927535, tolerance = 1e-7)
})

# test_that("Replicate Lee & Zhang 2013", {
#   dat <- read.csv("../data/lz-oa2.1.csv")
#   expect_equal(myers_n(dat$age, dat$freq), 20)
# })
