//
//  Geometry.swift
//  TextShooter
//
//  Created by Niu Panfeng on 19/11/2016.
//  Copyright © 2016 NaPaFeng. All rights reserved.
//

import Foundation
import UIKit

//计算两点之间的距离
func pointDistance(p1: CGPoint, _ p2: CGPoint) -> CGFloat {
    return CGFloat(    sqrtf(  powf(Float(p2.x-p1.x),2) + powf(Float(p2.y-p1.y),2)  )    )
}
//向量乘以系数
func vectorMultiply(v: CGVector, _ m: CGFloat) -> CGVector {
    return CGVectorMake(v.dx * m, v.dy * m)
}
//根据亮两点计算向量
func vectorBetweenPoints(p1: CGPoint, _ p2: CGPoint) -> CGVector {
    return CGVectorMake(p2.x - p1.x, p2.y - p1.y)
}
//计算向量的长度
func vectorLength(v: CGVector) -> CGFloat {
    return CGFloat(    sqrtf(  powf(Float(v.dx), 2) + powf(Float(v.dy), 2)  )    )
}