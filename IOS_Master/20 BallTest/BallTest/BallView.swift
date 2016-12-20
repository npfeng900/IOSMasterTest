//
//  BallView.swift
//  Ball
//
//  Created by Niu Panfeng on 24/11/2016.
//  Copyright © 2016 NaPaFeng. All rights reserved.
//

import UIKit
import CoreMotion

class BallView: UIView {

    var acceleration = CMAcceleration(x: 0, y: 0, z: 0)
    private let image: UIImage! = UIImage(named: "ball")
    private var ballXVelocity = 0.0
    private var ballYVelocity = 0.0
    private var lastUpdateTime = NSDate()
    private var currentPoint: CGPoint = CGPointZero {
        didSet{
            var newX = currentPoint.x
            var newY = currentPoint.y
            if newX < 0 {
                newX = 0
                ballXVelocity = -ballXVelocity/2.0
            } else if newX > bounds.size.width - image.size.width {
                newX = bounds.size.width - image.size.width
                ballXVelocity = -ballXVelocity/2.0
            }
            if newY < 0 {
                newY = 0
                ballYVelocity = -ballYVelocity/2.0
            } else if newY > bounds.size.height - image.size.height {
                newY = bounds.size.height - image.size.height
                ballYVelocity = -ballYVelocity/2.0
            }
            
            currentPoint = CGPointMake(newX, newY)
            let currentRect = CGRectMake(newX, newY, newX+image.size.width, newY+image.size.height)
            let prevRect = CGRectMake(oldValue.x, oldValue.y, oldValue.x+image.size.width, oldValue.y+image.size.height)
            
            setNeedsDisplayInRect(CGRectUnion(currentRect,prevRect))
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("ballView->init->bounds:\(bounds)")
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    //ball的初始位置
    func commonInit() -> Void {
        currentPoint = CGPointMake((bounds.size.width/1.0) + (image.size.width/2.0), (bounds.size.height/2.0) + (image.size.height/2.0))
        print("ballView->commonInit->bounds:\(bounds)")
        print("ballView->commonInit->currentPoint:\(currentPoint)")

    }
    //画
    override func drawRect(rect: CGRect) {
        image.drawAtPoint(currentPoint)
    }
    //更新currentPoint，ballXVelocity，ballYVelocity，lastUpdateTime
    func update() {
        let now = NSDate()
        let secondsSinceLastDraw = now.timeIntervalSinceDate(lastUpdateTime)
        ballXVelocity += acceleration.x * secondsSinceLastDraw
        ballYVelocity -= acceleration.y * secondsSinceLastDraw //坐标系y轴相反
        lastUpdateTime = now
        let xDeta = secondsSinceLastDraw * ballXVelocity * 500
        let yDeta = secondsSinceLastDraw * ballYVelocity * 500
        
        currentPoint = CGPointMake(currentPoint.x + CGFloat(xDeta), currentPoint.y + CGFloat(yDeta))
        
    }
    
    func printBounds() {
         print("ballView_bounds:\(bounds)")
    }

}
