//
//  GradientCircleView.swift
//  BaseProject
//
//  Created by 小二黑挖土 on 2018/5/4.
//  Copyright © 2018年 Lemon. All rights reserved.
//

import UIKit

let kStrokeLineWidth:CGFloat = 10.0

class GradientCircleView: UIView {
    //圆环宽度
    var width:CGFloat = 10.0
    
    lazy var shapelayer:CAShapeLayer = {
        let shape = CAShapeLayer()
        //画笔颜色，即线宽颜色
        shape.strokeColor = UIColor.darkGray.cgColor
        //填充颜色，路径填充区域颜色
        shape.fillColor = UIColor.clear.cgColor
        shape.lineWidth = kStrokeLineWidth
        return shape
    }()
    
    lazy var gradientLayer:CAGradientLayer = {
        let gradient = CAGradientLayer()
        return gradient
    }()
    
    var drawn:Bool = false
    var timer:Timer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialViews()
    }
    
    func initialViews() {
        timer = Timer(timeInterval: 0.1, target: self, selector: #selector(timerRun), userInfo: nil, repeats: true)
//        timer?.fireDate = NSDate.distantFuture
        RunLoop.current.add(timer!, forMode: RunLoopMode.defaultRunLoopMode)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if !drawn {
            let center = CGPoint(x: self.bounds.width/2, y: self.bounds.height/2)
            let radius = min(self.frame.size.width, self.frame.size.height)/2-kStrokeLineWidth
//            let minRadius = radius-width
            let unit = CGFloat(Double.pi)/180
            let startAngle = 120*unit
            let endAngle = 60*unit
//            let p1 = CGPoint(x: cos(startAngle)*minRadius+center.x, y: sin(startAngle)*minRadius+center.y)
//            let p2 = CGPoint(x: cos(startAngle)*radius+center.x, y: sin(startAngle)*radius+center.y)
//            let p3 = CGPoint(x: cos(endAngle)*minRadius+center.x, y: sin(endAngle)*minRadius+center.y)
//            let p4 = CGPoint(x: cos(endAngle)*radius+center.x, y: sin(endAngle)*radius+center.y)
            //构造路径
//            let path = UIBezierPath()
//            path.move(to: p1)
//            path.addArc(withCenter: center, radius: minRadius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
//            path.addLine(to: p3)
//            path.addLine(to: p4)
//            path.addArc(withCenter: center, radius: radius, startAngle: endAngle, endAngle: startAngle, clockwise: false)
//            path.addLine(to: p2)
//            path.close()
            
            let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
            shapelayer.path = path.cgPath
            shapelayer.strokeEnd = 0
            
            //因为颜色渐变只能沿一条直线，所以只能曲线救国
            let leftGradient = CAGradientLayer()
            leftGradient.startPoint = CGPoint(x: 0.5, y: 1)
            leftGradient.endPoint = CGPoint(x: 0.5, y: 0)
            leftGradient.colors = [UIColor.red.cgColor,UIColor.green.cgColor]
            leftGradient.frame = CGRect(x: 0, y: 0, width: self.frame.size.width/2, height: self.frame.size.height)
            leftGradient.locations = [0.6,0.7,1]
            let rightGradient = CAGradientLayer()
            rightGradient.startPoint = CGPoint(x: 0.5, y: 0)
            rightGradient.endPoint = CGPoint(x: 0.5, y: 1)
            rightGradient.colors = [UIColor.green.cgColor,UIColor.blue.cgColor]
            rightGradient.locations = [0.3,0.4,1]
            rightGradient.frame = CGRect(x: self.frame.size.width/2, y: 0, width: self.frame.size.width/2, height: self.frame.size.height)
            gradientLayer.addSublayer(leftGradient)
            gradientLayer.addSublayer(rightGradient)
            gradientLayer.mask = shapelayer
            
            self.layer.addSublayer(gradientLayer)
            self.backgroundColor = UIColor.clear
            
            drawn = true
        }
    }
    
    static var cout:CGFloat = 0
    @objc func timerRun() {
        GradientCircleView.cout += 1
        self.shapelayer.strokeEnd = GradientCircleView.cout/10.0
        if GradientCircleView.cout == 10 {
            timer?.invalidate()
            timer = nil
        }
    }
}
