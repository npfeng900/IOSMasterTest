//
//  BulletNode.swift
//  TextShooter
//
//  Created by Niu Panfeng on 20/11/2016.
//  Copyright © 2016 NaPaFeng. All rights reserved.
//

import UIKit
import SpriteKit

class BulletNode: SKNode {
    var thrust: CGVector = CGVectorMake(0, 0)
    
    override init() {
        super.init()
        name = "Bullet \(self)"
        initNodeGraph()
        initPhysicsBody()
        
    }
    private func initNodeGraph() {
        let dot = SKLabelNode(fontNamed: "Courier")
        dot.fontSize = 40
        dot.fontColor = SKColor.blackColor()
        dot.text = "."
        addChild(dot)
    }
    private func initPhysicsBody() {
        let body = SKPhysicsBody(circleOfRadius: 1)
        body.dynamic = true
        body.categoryBitMask = BulletCategory
        body.contactTestBitMask = EnemyCateGory //******************
        body.collisionBitMask =  EnemyCateGory   //******************
        body.fieldBitMask = GravityFieldCategory
        body.mass = 0.01
        physicsBody = body
    }
    //归档化处理
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let dx = aDecoder.decodeFloatForKey("thrustX")
        let dy = aDecoder.decodeFloatForKey("thrustY")
        thrust = CGVectorMake(CGFloat(dx), CGFloat(dy))
    }
    override func encodeWithCoder(aCoder: NSCoder) {
        super.encodeWithCoder(aCoder)
        aCoder.encodeFloat(Float(thrust.dx), forKey: "thrustX")
        aCoder.encodeFloat(Float(thrust.dy), forKey: "thrustY")
    }
    //
    class func bullet(from start: CGPoint, toward destination: CGPoint) -> BulletNode {
        let bullet = BulletNode()
        bullet.position = start
        let movement = vectorBetweenPoints(start, destination)
        let magitude = vectorLength(movement)
        let scaleMovement = vectorMultiply(movement, 1/magitude)//方向的单位向量
        
        let thrustMagitude = CGFloat(100.0)                     //bullet的速度标量
        bullet.thrust = vectorMultiply(scaleMovement, thrustMagitude)
        
        bullet.runAction(SKAction.playSoundFileNamed("shoot.wav", waitForCompletion: false))
        
        return bullet
    }
    func applyRecurringForce() {
        physicsBody!.applyForce(thrust) //推动发射，每帧中到被要调用
    }
}
