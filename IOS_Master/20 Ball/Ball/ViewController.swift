//
//  ViewController.swift
//  Ball
//
//  Created by Niu Panfeng on 23/11/2016.
//  Copyright © 2016 NaPaFeng. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    private let updateInterval = 1.0/60.0
    private let motionManager = CMMotionManager()
    private let queue = NSOperationQueue()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("viewController:\(view.bounds)")
        print("viewController:\(view.frame)")
        // Do any additional setup after loading the view, typically from a nib.
        motionManager.deviceMotionUpdateInterval = updateInterval
        motionManager.startDeviceMotionUpdatesToQueue(queue) { (motionData: CMDeviceMotion?, error: NSError?) -> Void in
            let ballView = self.view as! BallView
            ballView.acceleration = motionData!.gravity
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                ballView.update()
            })
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

