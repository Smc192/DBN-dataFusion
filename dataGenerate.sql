-- `motorTemperature`
create table if not exists `motorTemperature`
(
`attribute` varchar(256) default 'attri' not null comment '属性名' primary key,
`ambient` double default 0 not null comment '主键',
`coolant` double default 0 not null comment '冷却剂温度',
`u_d` double default 0 not null comment 'd分量电压',
`u_q` double default 0 not null comment 'u分量电压',
`motor_speed` double default 0 not null comment '电机速度',
`i_d` double default 0 not null comment 'd分量电流',
`i_q` double default 0 not null comment 'q分量电流',
`pm` double default 0 not null comment '永磁体温度',
`stator_yoke` double default 0 not null comment '用热电偶测量的定子轭温度(℃)',
`stator_tooth` double default 0 not null comment '用热电偶测量的定子齿温度(°C)',
`stator_winding` double default 0 not null comment '用热电偶测量定子绕组温度(°C)',
`intercept` double default 0 not null comment '残差',
`standard deviation` double default 0 not null comment '标准差'
) comment '`motorTemperature`';