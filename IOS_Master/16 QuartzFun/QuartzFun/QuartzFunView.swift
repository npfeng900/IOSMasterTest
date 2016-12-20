//
//  QuartzFun.swift
//  QuartzFun
//
//  Created by Niu Panfeng on 17/11/2016.
//  Copyright © 2016 NaPaFeng. All rights reserved.
//
//M模型

import UIKit

extension UIColor {
    class func randomColor() -> UIColor {
        let red = CGFloat( Double(arc4random()%256) / 255 )
        let green = CGFloat( Double(arc4random()%256) / 255 )
        let blue = CGFloat( Double(arc4random()%256) / 255 )
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
enum Shape : UInt {
    case Line = 0, Rect, Ellipse, Image
}
enum DrawingColor : UInt {
    case Red = 0, Blue, Yellow, Green, Random
}

class QuartzFunView: UIView {
    //允许设定的属性
    var shape = Shape.Line
    var currentColor = UIColor.redColor()
    var useRandomColor = false
    //内部私有属性
    private let image = UIImage(named: "iphone")!
    private var firstTouchLocation: CGPoint = CGPointZero
    private var lastTouchLocation: CGPoint = CGPointZero
    private var redrawRect: CGRect = CGRectZero
    
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, 2.0)
        CGContextSetStrokeColorWithColor(context, currentColor.CGColor)
        CGContextSetFillColorWithColor(context, currentColor.CGColor)
        
        switch shape{
        case .Line:
            CGContextMoveToPoint(context, firstTouchLocation.x, firstTouchLocation.y)
            CGContextAddLineToPoint(context, lastTouchLocation.x, lastTouchLocation.y)
            CGContextStrokePath(context)
        case .Rect:
            CGContextAddRect(context, currentRect())
            CGContextDrawPath(context, CGPathDrawingMode.FillStroke)
        case .Ellipse:
            CGContextAddEllipseInRect(context, currentRect())
            CGContextDrawPath(context, CGPathDrawingMode.FillStroke)
        case .Image:
            let horizontalOffset = image.size.width / 2
            let verticalOFFset = image.size.height / 2
            let drawPoint = CGPointMake(lastTouchLocation.x - horizontalOffset, lastTouchLocation.y - verticalOFFset)
            image.drawAtPoint(drawPoint)
        }
    }
    func currentRect() -> CGRect {
        return CGRectMake(firstTouchLocation.x, firstTouchLocation.y, lastTouchLocation.x - firstTouchLocation.x, lastTouchLocation.y - firstTouchLocation.y)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if useRandomColor {
            currentColor = UIColor.randomColor()
        }
        //let touch = (touches as NSSet).anyObject() as! UITouch
        let touch = touches.first! as UITouch
        firstTouchLocation = touch.locationInView(self)
        lastTouchLocation = firstTouchLocation
        redrawRect = CGRectZero
        setNeedsDisplay()
    }
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first! as UITouch
        lastTouchLocation = touch.locationInView(self)
        
        if shape == .Image{
            let horizontalOffset = image.size.width / 2
            let verticalOFFset = image.size.height / 2
            redrawRect = CGRectMake(min(firstTouchLocation.x, lastTouchLocation.x)-horizontalOffset, min(firstTouchLocation.y, lastTouchLocation.y)-verticalOFFset, currentRect().width+image.size.width, currentRect().height+image.size.height)
        } else {
            redrawRect = CGRectUnion(redrawRect, currentRect())
        }
        setNeedsDisplayInRect(redrawRect)
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first! as UITouch
        lastTouchLocation = touch.locationInView(self)
        
        if shape == .Image{
            let horizontalOffset = image.size.width / 2
            let verticalOFFset = image.size.height / 2
            redrawRect = CGRectMake(min(firstTouchLocation.x, lastTouchLocation.x)-horizontalOffset, min(firstTouchLocation.y, lastTouchLocation.y)-verticalOFFset, currentRect().width+image.size.width, currentRect().height+image.size.height)
        } else {
            redrawRect = CGRectUnion(redrawRect, currentRect())
            
        }
        setNeedsDisplayInRect(redrawRect)
       
    }

}
