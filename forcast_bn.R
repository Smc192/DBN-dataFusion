library(bnlearn)
library(testthat)
library(dbnR)
# 数据离散化
dt <- motor
dt_train <- dt[1:2400, ]
dt_test <- dt[2401:3000, ]
# 使用爬山算法进行结构学习
bayesnet <- dmmhc(dt_train)
# 显示网络图
plot(bayesnet)
# 参数学习
fitted <- bn.fit(bayesnet, dt_train, method = "mle-g")
# 训练样本预测
pre <- predict(fitted, data = dt_test, node = "stator_winding")
# print(pre)
print(dt_test)
col_name <- "motor_speed"
col_data <- dt_test[, 11]
print(col_data)
# 计算预测数据的MAE值
num <- abs(pre - col_data)
print(num)
mae <- mean(unlist(num), na.rm = TRUE)
cat("MAE:", mae)
