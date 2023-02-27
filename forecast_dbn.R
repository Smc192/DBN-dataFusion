library("dbnR")
library("testthat")
test_that("forecast_dbn works", {
  data(motor)
  dt <- motor
  # dt <- read.csv("F:\\data set\\data\\archive\\measures_v2.csv")
  size <- 2
  dt_train <- dt[1:2400, ]
  dt_test <- dt[2401:3000, ]
  f_dt_train <- fold_dt(dt_train, size)
  f_dt_test <- fold_dt(dt_test, size)

  net <- learn_dbn_struc(dt_train, size = size, method = "dmmhc")
  fit <- fit_dbn_params(net, f_dt_train, method = "mle-g")
  res_fore <- forecast_ts(f_dt_test, fit,
    obj_vars = "stator_winding_t_0", rep = 2,
    ini = 1, len = 50, print_res = T, plot_res = T
  )

  expect_equal(1, 1)
})
