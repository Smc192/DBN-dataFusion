library(dbnR)
library(bnlearn)
library(openxlsx)

# sp <- read.csv("F:\\pythonProject\\DBN\\data\\cnc\\final.csv")
sp <- motor
## -#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-# structure learning -#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
dt_train <- sp[1:2400, ]
dt_test <- dt[2401:3000, ]
size <- 2
## no constrains
net <- learn_dbn_struc(dt_train, size, method = "dmmhc")
# plot_dynamic_network(net)
## -#-#-#-#-#-#-#-#-#-#-#-#--#-#-#-#-#-#-# Parameters learning -#-#-#-#-#-#-#-#-#-#-#-#-
f_dt_train <- fold_dt(dt_train, size)
fit <- fit_dbn_params(net, f_dt_train, method = "mle-g")
# print(fit)
# -------- Conditional density save ---------------------
weigh_num <- 0
for (i in 1:length(fit)) {
  if (length(fit[[i]]$coefficients) > 1) {
    weigh_num <- weigh_num + length(fit[[i]]$coefficients) - 1
  }
}
wei_arr <- array(0, dim = c(weigh_num, 5)) # initialize weight array
raw_ind <- 0
for (i in 1:length(fit)) {
  if (length(fit[[i]]$coefficients) > 1) {
    for (j in 2:length(fit[[i]]$coefficients)) {
      raw_ind <- raw_ind + 1
      wei_arr[raw_ind, 1] <- names(fit[[i]]$coefficients[j])
      wei_arr[raw_ind, 2] <- names(fit[i])
      wei_arr[raw_ind, 3] <- round(fit[[i]]$coefficients[j][[1]], 4)
      wei_arr[raw_ind, 4] <- round(fit[[i]]$coefficients[[1]], 4)
      wei_arr[raw_ind, 5] <- round(fit[[i]]$sd[[1]], 4)
    }
  }
}
# print(wei_arr)
write.csv(wei_arr, file = "F:/pythonProject/dbn-master/out/net_weigh.csv", row.names = FALSE)

