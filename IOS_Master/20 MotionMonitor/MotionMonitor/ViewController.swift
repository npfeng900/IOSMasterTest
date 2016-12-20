//
//  ViewController.swift
//  MotionMonitor
//
//  Created by Niu Panfeng on 23/11/2016.
//  Copyright © 2016 NaPaFeng. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    @IBOutlet weak var gyroscopeLabel: UILabel!
    @IBOutlet weak var accelerometerLabel: UILabel!
    @IBOutlet weak var attitudeLabel: UILabel!
    
    private let motionManager = CMMotionManager()
    private let queue = NSOperationQueue()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("Befor")
        if motionManager.deviceMotionAvailable
        {
            print("deviceMotionAvailable")
            motionManager.deviceMotionUpdateInterval = 0.1
            motionManager.startDeviceMotionUpdatesToQueue(queue,
                withHandler: { (motion: CMDeviceMotion?, error: NSError?) -> Void in
                let rotationRate = motion!.rotationRate
                let gravity = motion!.gravity
                let userAcc = motion!.userAcceleration
                let attitude = motion!.attitude
                
                let gyroscopeText = String(format: "Rotation Rate:\n--------------" + "X:%+.2f\nY:%+.2f\nZ:%+.2f\n", rotationRate.x, rotationRate.y, rotationRate.z)
                let acceleratorText = String(format: "Acceleration:\n--------------" + "Gravity X:%+.2f\tUser X:%+.2f\n" + "Gravity Y:%+.2f\tUser Y:%+.2f\n" + "Gravity Z:%+.2f\tUser Z:%+.2f\n", gravity.x, userAcc.x, gravity.y, userAcc.y, gravity.z, userAcc.z)
                let attitudeText = String(format: "Attitude:\n--------------" + "Roll:%+.2f\nPitch:%+.2f\nYaw:%+.2f\n", attitude.roll, attitude.pitch, attitude.yaw)
                
                dispatch_async(dispatch_get_main_queue(),
                    { () -> Void in
                    self.gyroscopeLabel.text = gyroscopeText
                    self.accelerometerLabel.text = acceleratorText
                    self.attitudeLabel.text = attitudeText
                })
                
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

