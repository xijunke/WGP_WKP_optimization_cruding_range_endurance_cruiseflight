# The optimized and predicted results that FWMAV can achieve hovering and low-speed forward flight with minimal energy consumption
# FWMAV能够实现悬飞和低速前飞时能量消耗最小的优化结果和预测结果

## 本文件夹的程序改编自WingM6_2_10variable_group_Wang_wingbeatM, 用于研究扑翼概念设计的巡航航程和时间，优化计算翅膀运动学规律和形貌学参数
## Ref.to. WingM7_1_10variable_group_flight_range, only noted for this program owner and maintainer.

### 0.hybrid_GA_fminsearch_WingM4_4_2由hybrid_GA_fminsearch_WingM4_4_1进化修改而来

### 1.该文件夹下为10变量GA混合优化之程序—fmincon—搜索算法

### 2.含翅膀形貌学和运动学参数(采用Wang ZJ wingbeat pattern 运动学规律)共计10个变量

### 3.功率调用函数和气动力调用函数一起调用同一个函数Aero_F_M_fruitfly——程序较简洁

### 4.变量约束区间改小——注意数据的上下限修改——直指频率约束f∈[0,300];

### 5.kenimatics_wing_and_AoA_fruitfly_sim输出(1000*9)矩阵


# Running Genetic Algorithm (GA) optimization process and results for different mass FWMAV

## GA optimization process and results for 80mg FWMAV

![ConcepDes_FMAV_delta](https://github.com/xijunke/WGP_WKP_optimization_cruding_range_endurance_cruiseflight/20160402_optimal_results_for_80mg_FWMAV/20160402-WingM7_1_10variable_group_flight_range-optimal_results.png)

(https://github.com/xijunke/WGP_WKP_optimization_cruding_range_endurance_cruiseflight/20160402_optimal_results_for_80mg_FWMAV/攻角随时间的变化规律.png)

## GA optimization process and results for 200mg FWMAV

![ConcepDes_FMAV_delta](https://github.com/xijunke/WGP_WKP_optimization_cruding_range_endurance_cruiseflight/20160402_optimal_results_for_80mg_FWMAV/20160402-WingM7_1_10variable_group_flight_range-optimal_results.png)

## GA optimization process and results for 4g FWMAV

![ConcepDes_FMAV_delta](https://github.com/xijunke/WGP_WKP_optimization_cruding_range_endurance_cruiseflight/20160402_optimal_results_for_80mg_FWMAV/20160402-WingM7_1_10variable_group_flight_range-optimal_results.png)









