//
//  GameScene.swift
//  TextShooter
//
//  Created by Niu Panfeng on 18/11/2016.
//  Copyright (c) 2016 NaPaFeng. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    private var levelNumber: UInt
    private var livesNumber: Int {
        didSet {
            let lives = childNodeWithName("LivesLabel") as! SKLabelNode
            lives.text = "Lives:\(livesNumber)"
        }
    }
    private var finished = false
    private let playerNode: PlayerNode = PlayerNode()
    private let enemies = SKNode()
    private let bullets = SKNode()
    private let forceFields = SKNode()
    
    //类方法，相当于静态方法。这里是个工厂方法。PLUS：类不支持类属性，只支持计算属性返回一个类
    class func scene(size: CGSize, levelNumber: UInt) -> GameScene {
        return GameScene(size: size, levelNumber: levelNumber)
    }
    //初始化
    override convenience init(size: CGSize) {
        self.init(size: size, levelNumber: 1)
    }
    init(size:CGSize, levelNumber: UInt) {
        self.levelNumber = levelNumber
        self.livesNumber = 5
        super.init(size: size)
        //场景的初始化
        backgroundColor = SKColor.whiteColor()
        //
        let level = SKLabelNode(fontNamed: "Courier")
        level.fontSize = 13
        level.fontColor = SKColor.blackColor()
        level.name = "LevelLabel"
        level.text = "Level:\(levelNumber)"
        level.verticalAlignmentMode = .Top
        level.horizontalAlignmentMode = .Left
        level.position = CGPointMake(0, frame.size.height)
        addChild(level)
        //
        let lives = SKLabelNode(fontNamed: "Courier")
        lives.fontSize = 13
        lives.fontColor = SKColor.blackColor()
        lives.name = "LivesLabel"
        lives.text = "Lives:\(livesNumber)"
        lives.verticalAlignmentMode = .Top
        lives.horizontalAlignmentMode = .Right
        lives.position = CGPointMake(frame.size.width, frame.size.height)
        addChild(lives)
        //
        playerNode.position = CGPointMake(CGRectGetMidX(frame), CGRectGetHeight(frame) * 0.09)
        addChild(playerNode)
        //
        spawnEnemies()
        addChild(enemies)
        //
        addChild(bullets)
        //
        addChild(forceFields)
        createForceFields()
        
        
        
        //
        physicsWorld.gravity = CGVectorMake( 0, -1)
        physicsWorld.contactDelegate = self
    }
    
    //归档化处理
    required init?(coder aDecoder: NSCoder) {
        levelNumber = UInt(aDecoder.decodeIntegerForKey("level"))
        livesNumber = aDecoder.decodeIntegerForKey("lives")
        super.init(coder: aDecoder)
    }
    override func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeInteger(Int(levelNumber), forKey: "level")
        aCoder.encodeInteger(livesNumber, forKey: "lives")
    }
    //触摸时调用
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        for touch in touches {
            let location = touch.locationInNode(self)
            if location.y < CGRectGetHeight(frame) * 0.2
            {
                let target = CGPointMake(location.x, location.y)
                playerNode.moveToward(target)
            }
            else
            {
                let bullet = BulletNode.bullet(from: playerNode.position, toward: location)
                bullets.addChild(bullet)
            }
        }
    }
    //生成enemy
    private func spawnEnemies() {
        let count = UInt( log(Float(levelNumber)) ) + levelNumber
        for var i: UInt = 0; i < count; i++
        {
            let enemy = EnemyNode()
            let size = frame.size
            let x = arc4random_uniform(UInt32(size.width * 0.8)) + UInt32(size.width * 0.1)
            let y = arc4random_uniform(UInt32(size.height * 0.5)) + UInt32(size.height * 0.5)
            enemy.position = CGPointMake(CGFloat(x), CGFloat(y))
            enemies.addChild(enemy)
        }
    }
    //渲染每帧时调用
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        if finished {
            return
        }
        updateBullets()
        updateEnemies()
        if !checkForGameOver() {
             checkForNextLevel()
        }
    }
    //
    private func updateBullets() {
        var bulletsToRemove: [BulletNode] = []
        for bullet in bullets.children as! [BulletNode]
        {
            if !CGRectContainsPoint(frame, bullet.position) {
                bulletsToRemove.append(bullet)
                continue
            }
            bullet.applyRecurringForce()
        }
        bullets.removeChildrenInArray(bulletsToRemove)
    }
    //
    private func updateEnemies() {
        var enemiesToRemove: [EnemyNode] = []
        for enemy in enemies.children as! [EnemyNode]
        {
            if !CGRectContainsPoint(frame, enemy.position) {
                enemiesToRemove.append(enemy)
                continue
            }
        }
        enemies.removeChildrenInArray(enemiesToRemove)
    }
    //是否进入下一关的函数
    private func checkForNextLevel() {
        if enemies.children.isEmpty {
            goToNextLevel()
        }
    }
    private func goToNextLevel() {
        finished = true
        
        let label = SKLabelNode(fontNamed: "Courier")
        label.fontSize = 28
        label.fontColor = SKColor.blueColor()
        label.text = "Level\(levelNumber) Completed!"
        label.position = CGPointMake(frame.size.width / 2, frame.size.height / 2)
        addChild(label)
        
        let nextLevel = GameScene(size: frame.size, levelNumber: levelNumber + 1)
        nextLevel.livesNumber = livesNumber
        view!.presentScene(nextLevel, transition: SKTransition.flipHorizontalWithDuration(1.5))
    }
    //是否结束
    private func checkForGameOver() -> Bool {
        if livesNumber == 0 {
            triggerGameOver()
            return true
        }
        return false
    }
    private func triggerGameOver() {
        finished = true
        
        let path = NSBundle.mainBundle().pathForResource("EnemyExplosion", ofType: "sks")
        let explosion = NSKeyedUnarchiver.unarchiveObjectWithFile(path!) as! SKEmitterNode
        explosion.numParticlesToEmit = 200
        explosion.position = playerNode.position
        scene!.addChild(explosion)
        playerNode.removeFromParent()
        
        let gameOver = GameOverScene(size: frame.size)
        view!.presentScene(gameOver, transition: SKTransition.doorsOpenVerticalWithDuration(1))
        
        runAction(SKAction.playSoundFileNamed("gameOver.wav", waitForCompletion: false))
    }
    //
    func didBeginContact(contact: SKPhysicsContact) {
        if contact.bodyA.categoryBitMask == contact.bodyB.categoryBitMask
        {
            //A、B时同一种物理对象
            let nodeA = contact.bodyA.node!
            let nodeB = contact.bodyB.node!
            
            nodeA.friendlyBumpFrom(nodeB)
            nodeB.friendlyBumpFrom(nodeA)
        }
        else
        {
            var attacker: SKNode
            var attackee: SKNode
            
            if contact.bodyA.categoryBitMask > contact.bodyB.categoryBitMask
            {
                //A攻击B
                attacker = contact.bodyA.node!
                attackee = contact.bodyB.node!
            }
            else
            {
                //B攻击A
                attacker = contact.bodyB.node!
                attackee = contact.bodyA.node!
            }
            
            if attackee is PlayerNode
            {
                livesNumber--
            }
            
            attackee.receiveAttacker(attacker, contact: contact)
            bullets.removeChildrenInArray([attacker])
            enemies.removeChildrenInArray([attacker])
        }
    }
    
    private func createForceFields() {
        let fieldCount = 3
        let size = frame.size
        let sectionWidth = Int(size.width) / fieldCount
        
        for var i = 0; i < fieldCount; i++
        {
            let x = CGFloat( arc4random_uniform(UInt32(sectionWidth)) + UInt32(i*sectionWidth) )
            let y = CGFloat( arc4random_uniform(UInt32(size.height*0.25)) + UInt32(size.height*0.25) )

            let gravityField = SKFieldNode.radialGravityField()
            gravityField.position = CGPointMake(x, y)
            gravityField.categoryBitMask = GravityFieldCategory
            gravityField.strength = 4
            gravityField.falloff = 2
            gravityField.region = SKRegion(size: CGSizeMake(size.width*0.3,size.height*0.1))
            forceFields.addChild(gravityField)
            
            let fieldLoactionNode = SKLabelNode(fontNamed: "Courier")
            fieldLoactionNode.fontSize = 16
            fieldLoactionNode.fontColor = SKColor.redColor()
            fieldLoactionNode.name = "GravityField"
            fieldLoactionNode.text = "*"
            fieldLoactionNode.position = CGPointMake(x, y)
            forceFields.addChild(fieldLoactionNode)
        }
    }
}
