//
//  GameOverScene.swift
//  TextShooter
//
//  Created by Niu Panfeng on 21/11/2016.
//  Copyright © 2016 NaPaFeng. All rights reserved.
//

import UIKit
import SpriteKit

class GameOverScene: SKScene {
    override init(size: CGSize) {
        super.init(size: size)
        backgroundColor = SKColor.purpleColor()
        //
        let text = SKLabelNode(fontNamed: "Courier")
        text.fontSize = 50
        text.fontColor = SKColor.whiteColor()
        text.text = "Game Over"
        text.position = CGPointMake(frame.size.width/2, frame.size.height/2)
        addChild(text)
    }
    
    override func didMoveToView(view: SKView) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3*Int64(NSEC_PER_SEC)), dispatch_get_main_queue()) { () -> Void in
            let start = GameStartScene(size: self.frame.size)
            view.presentScene(start, transition: SKTransition.doorwayWithDuration(1.0))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
