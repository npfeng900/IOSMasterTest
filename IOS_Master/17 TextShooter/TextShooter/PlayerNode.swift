//
//  PlayerNode.swift
//  TextShooter
//
//  Created by Niu Panfeng on 19/11/2016.
//  Copyright © 2016 NaPaFeng. All rights reserved.
//

import UIKit
import SpriteKit
import Foundation

class PlayerNode: SKNode {
    override init() {
        super.init()
        name = "Player \(self)"
        initNodeGraph()
        initPhysicsBody()
    }
    //
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    //
    private func initNodeGraph(){
        let label = SKLabelNode(fontNamed: "Courier")
        label.fontSize = 40
        label.fontColor = SKColor.darkGrayColor()
        label.name = "label"
        label.text = "v"
        label.zRotation = CGFloat(M_PI)
        
        self.addChild(label)
    }
    private func initPhysicsBody() {
        let body = SKPhysicsBody(rectangleOfSize: CGSizeMake(40, 40))
        body.affectedByGravity = false
        body.categoryBitMask = PlayerCategory
        body.contactTestBitMask = EnemyCateGory  //******************
        body.collisionBitMask = 0                //******************
        body.fieldBitMask = 0
        physicsBody = body
    }
    //
    func moveToward(location: CGPoint) {
        removeActionForKey("movement")
        let distance = pointDistance(position, location)
        let screenWidth = UIScreen.mainScreen().bounds.size.width
        let duration = NSTimeInterval(2 * distance / screenWidth)
        runAction(SKAction.moveTo(location, duration: duration), withKey: "movement")
        
        removeActionForKey("wobbing")
        let wobbleTime = 0.3
        let wobbleCount = Int(duration/wobbleTime)
        let halfWobbleTime = wobbleTime / 2
        let wobbling = SKAction.sequence([SKAction.scaleXTo(0.2, duration: halfWobbleTime), SKAction.scaleXTo(1.0, duration: halfWobbleTime)])//x轴放大缩小
        runAction(SKAction.repeatAction(wobbling, count: wobbleCount), withKey: "wobbing")
        
    }
    //
    override func receiveAttacker(attacker: SKNode, contact: SKPhysicsContact) {
        let path = NSBundle.mainBundle().pathForResource("EnemyExplosion", ofType: "sks")
        let explosion = NSKeyedUnarchiver.unarchiveObjectWithFile(path!) as! SKEmitterNode
        explosion.numParticlesToEmit = 50
        explosion.position = contact.contactPoint
        scene!.addChild(explosion)
        
        runAction(SKAction.playSoundFileNamed("playerHit.wav", waitForCompletion: false))
    }
}
