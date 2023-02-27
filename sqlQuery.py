import mysql.connector
import numpy as np
from scipy.stats import norm
import matplotlib.pyplot as plt


# 查询数据残差和标准差
def select_data_sd(str_attri):
    global intercept, sd
    select_sql = "SELECT intercept,standard_deviation FROM motortemperature WHERE attribute=%s"
    cursor.execute(select_sql, (str_attri,))
    results = cursor.fetchall()
    for rows in results:
        intercept = rows[0]
        sd = rows[1]
    return intercept, sd


# 查询数据均值
def select_data_mean(str_attri):
    select_sql = "SELECT attribute," + str_attri + " FROM motortemperature"
    cursor.execute(select_sql)
    results = cursor.fetchall()
    mean = {}
    j = 0
    for i in range(0, results.__len__()):
        if results[i][1] != 0:
            mean[j] = results[i]
            j = j + 1
    return mean


# 关闭数据库连接
def close_conn():
    cursor.close()
    conn.close()


if __name__ == '__main__':
    # 连接数据库
    conn = mysql.connector.connect(user='root', password='password', host='localhost',
                                   database='motortemp')
    cursor = conn.cursor()
    # 定义高斯分布的参数
    intercept, sd = select_data_sd("coolant")
    mean_num = select_data_mean("ambient")
    evidence = {}
    cancha = 0.00
    for i in range(0, mean_num.__len__()):
        evidence[i] = input("请给出该证据值证据：" + "(" + mean_num[i][0] + ") = ")
    for i in range(0, evidence.__len__()):
        cancha = cancha + float(evidence[i]) * float(mean_num[i][1])
    mean = intercept + cancha
    # 生成符合目标数据的范围值
    # 测试数据：i_q = 54, motor_speed = 1380, stator_tooth = 18, u_d = -33
    x = np.linspace(18.8, 19.2, num=100)
    y = norm.pdf(x, mean, sd)
    print(y)
    # 测试结果 ambient = 19左右
    # 画出概率密度函数
    plt.plot(x, y)
    plt.title('Gaussian Distribution')
    plt.xlabel('X')
    plt.ylabel('Probability Density')
    plt.show()
