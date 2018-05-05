# GradientCircleView
## 自定义封装的环形进度条指示器


![img](https://github.com/xuanyuelin/GradientCircleView/blob/master/circleIndicator.gif)


### 实现思路
1. 绘制圆形路径
2. 使用渐变层
   渐变方向只能为直线，若想实现曲线效果，需分区域渐变
3. 改变CALayer的strokeEnd属性实现隐式动画
   
