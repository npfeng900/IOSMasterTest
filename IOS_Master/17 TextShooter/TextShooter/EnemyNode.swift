//
//  EnemyNode.swift
//  TextShooter
//
//  Created by Niu Panfeng on 20/11/2016.
//  Copyright © 2016 NaPaFeng. All rights reserved.
//

import UIKit
import SpriteKit

class EnemyNode: SKNode {
    override init() {
        super.init()
        name = "Enemy \(self)"
        initNodeGraph()
        initPhysicsBody()
    }
    //
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    //
    private func initNodeGraph(){
        let topRow = SKLabelNode(fontNamed: "Courier-Bold")
        topRow.fontSize = 20
        topRow.fontColor = SKColor.brownColor()
        topRow.text = "X X"
        topRow.position = CGPointMake(0, 15)
        addChild(topRow)
        
        let midRow = SKLabelNode(fontNamed: "Courier-Bold")
        midRow.fontSize = 20
        midRow.fontColor = SKColor.brownColor()
        midRow.text = "X"
        addChild(midRow)
        
        let bottomRow = SKLabelNode(fontNamed: "Courier-Bold")
        bottomRow.fontSize = 20
        bottomRow.fontColor = SKColor.brownColor()
        bottomRow.text = "X X"
        bottomRow.position = CGPointMake(0, -15)
        addChild(bottomRow)
    }
    private func initPhysicsBody() {
        let body = SKPhysicsBody(rectangleOfSize: CGSizeMake(40, 40))
        body.affectedByGravity = false
        body.categoryBitMask = EnemyCateGory
        body.contactTestBitMask = PlayerCategory | EnemyCateGory | BulletCategory //******************
        body.collisionBitMask = BulletCategory | EnemyCateGory | PlayerCategory  //******************
        body.fieldBitMask = 0
        body.mass = 0.2
        body.angularDamping = 0
        body.linearDamping = 0
        physicsBody = body
    }
    override func receiveAttacker(attacker: SKNode, contact: SKPhysicsContact) {
        physicsBody!.affectedByGravity = true
        
        let force = vectorMultiply(attacker.physicsBody!.velocity, contact.collisionImpulse)
        let myContact = scene!.convertPoint(contact.contactPoint, toNode: self)
        
        physicsBody!.applyForce(force, atPoint: myContact)
        
        let path = NSBundle.mainBundle().pathForResource("BulletExplosion", ofType: "sks")
        let explosion = NSKeyedUnarchiver.unarchiveObjectWithFile(path!) as! SKEmitterNode
        explosion.numParticlesToEmit = 20
        explosion.position = contact.contactPoint
        scene!.addChild(explosion)
        
        runAction(SKAction.playSoundFileNamed("enemyHit.wav", waitForCompletion: false))
    }
    override func friendlyBumpFrom(node: SKNode) {
        physicsBody!.affectedByGravity = true
    }
}
