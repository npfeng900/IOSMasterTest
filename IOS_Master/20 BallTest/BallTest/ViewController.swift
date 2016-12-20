//
//  ViewController.swift
//  BallTest
//
//  Created by Niu Panfeng on 24/11/2016.
//  Copyright © 2016 NaPaFeng. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    /*
    private let updateInterval = 1.0/60.0
    private let motionManager = CMMotionManager()
    private let queue = NSOperationQueue()
    */
    private var accelerationGravity = CMAcceleration(x: 0, y: 0, z: 0)
    private var updateTimer: NSTimer!
    private let updateInterval = 1.0/60.0
    private var ballView: BallView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewController->viewDidLoad->bounds:\(view.bounds)")
        // Do any additional setup after loading the view, typically from a nib.
        
        ballView = self.view as! BallView // 这条语句将BallView的bounds变为viewController的bounds
        ballView.printBounds()
        
        }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        updateTimer = NSTimer.scheduledTimerWithTimeInterval(updateInterval, target: self, selector: "updateView", userInfo: nil, repeats: true)
        
        
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        updateTimer.invalidate()
        updateTimer = nil
    }
    func updateView() -> Void {
        accelerationGravity.x = Double( (arc4random()%201) ) / 100 - 1
        accelerationGravity.y = Double( (arc4random()%201) ) / 100 - 1
        
        //let ballView = self.view as! BallView
        ballView.acceleration = accelerationGravity
        ballView.update()
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

