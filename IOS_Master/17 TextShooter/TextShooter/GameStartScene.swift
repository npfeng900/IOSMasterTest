//
//  GameStartScene.swift
//  TextShooter
//
//  Created by Niu Panfeng on 21/11/2016.
//  Copyright © 2016 NaPaFeng. All rights reserved.
//

import UIKit
import SpriteKit

class GameStartScene: SKScene {
    override init(size: CGSize) {
        super.init(size: size)
        backgroundColor = SKColor.greenColor()
        //
        let topLabel = SKLabelNode(fontNamed: "Courier")
        topLabel.fontSize = 48
        topLabel.fontColor = SKColor.blackColor()
        topLabel.text = "TextShooter"
        topLabel.position = CGPointMake(frame.size.width/2, frame.size.height*0.7)
        addChild(topLabel)
        //
        let bottomLabel = SKLabelNode(fontNamed: "Courier")
        bottomLabel.fontSize = 20
        bottomLabel.fontColor = SKColor.blackColor()
        bottomLabel.text = "Touch anywhere to start"
        bottomLabel.position = CGPointMake(frame.size.width/2, frame.size.height*0.3)
        addChild(bottomLabel)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let game = GameScene(size: frame.size)
        view!.presentScene(game, transition: SKTransition.doorwayWithDuration(1.0))
        
        runAction(SKAction.playSoundFileNamed("gameStart.wav", waitForCompletion: false))
    }
}
