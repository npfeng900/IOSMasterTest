//
//  ViewController.swift
//  State Lab
//
//  Created by Niu Panfeng on 15/11/2016.
//  Copyright © 2016 NaPaFeng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var label: UILabel!
    private var smiley: UIImage!
    private var smileyView: UIImageView!
    private var animate = false
    private var segementedControl: UISegmentedControl!
    private var segementIndex = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("VC:\(__FUNCTION__)")
        
        let bounds = view.bounds
        //label控件
        label = UILabel(frame:  CGRectMake(bounds.origin.x, CGRectGetMidY(bounds)-50, bounds.size.width, 100))
        label.font = UIFont(name: "Helvetica", size: 70)
        label.text = "Bzainga!"
        label.textAlignment = NSTextAlignment.Center
        label.backgroundColor = UIColor.clearColor()
        view.addSubview(label)
        //image控件
        smiley = UIImage(named: "smiley")
        smileyView = UIImageView(frame: CGRectMake(CGRectGetMidX(bounds)-42, CGRectGetMidY(bounds)/2 - 42, 84, 84))
        smileyView.contentMode = UIViewContentMode.Center
        smileyView.image = smiley
        view.addSubview(smileyView)
        //segement控件
        segementedControl = UISegmentedControl(items: ["One", "Two", "Three", "Four"])
        segementedControl.frame = CGRectMake(bounds.origin.x+20, CGRectGetMaxY(bounds)*3/4, bounds.size.width-40, 30)
        segementedControl.addTarget(self, action: "selectionChanged:", forControlEvents: UIControlEvents.ValueChanged)
        view.addSubview(segementedControl)
        segementIndex = NSUserDefaults.standardUserDefaults().integerForKey("segementIndex")
        segementedControl.selectedSegmentIndex = segementIndex
        //
        let center = NSNotificationCenter.defaultCenter()
        center.addObserver(self, selector: "applicationWillResignActive", name: UIApplicationWillResignActiveNotification, object: nil)
        center.addObserver(self, selector: "applicationDidBecomeActive", name: UIApplicationDidBecomeActiveNotification, object: nil)
        center.addObserver(self, selector: "applicationDidEnterBackground", name: UIApplicationDidEnterBackgroundNotification, object: nil)
        center.addObserver(self, selector: "applicationWillEnterForeground", name: UIApplicationWillEnterForegroundNotification, object: nil)
        
    }
    deinit {
        let center = NSNotificationCenter.defaultCenter()
        center.removeObserver(self, name: UIApplicationWillResignActiveNotification, object: nil)
        center.removeObserver(self, name: UIApplicationDidBecomeActiveNotification, object: nil)
        center.removeObserver(self, name: UIApplicationDidEnterBackgroundNotification, object: nil)
        center.removeObserver(self, name: UIApplicationWillEnterForegroundNotification, object: nil)
    }
    //////
    func rotateLabelDown(){
        UIView.animateWithDuration(4, animations: {
            self.label.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))//转180度
            },
            completion: { (Bool) -> Void in
                self.rotateLabelUp()
            })
    }
    func rotateLabelUp(){
        UIView.animateWithDuration(0.5, animations: {
            self.label.transform = CGAffineTransformMakeRotation(0)//转回起始位置
            },
            completion: { (Bool) -> Void in
                if self.animate
                {
                    //如果applicationDidBecomeActive，则继续旋转
                    self.rotateLabelDown()
                }
                else
                {
                    //如果applicationWillResignActive，完成rotateLabelUp中到0的位置，不再进行旋转了
                    print("Rotate End")
                }
            }
        )
    }
    //////
    func applicationWillResignActive() {
        print("\(__FUNCTION__)--VC")
        animate = false
    }
    func applicationDidBecomeActive() {
        print("\(__FUNCTION__)--VC")
        animate = true
        rotateLabelDown()
    }
    func applicationDidEnterBackground() {
        print("\(__FUNCTION__)--VC")
        //smiley = nil
        //smileyView.image = nil
        NSUserDefaults.standardUserDefaults().setInteger(segementIndex, forKey: "segementIndex")
        
        let app = UIApplication.sharedApplication()
        var taskId: UIBackgroundTaskIdentifier = UIBackgroundTaskInvalid
        taskId = app.beginBackgroundTaskWithExpirationHandler { () -> Void in
            print("Backgound task ran out of time and was teminated.")
            app.endBackgroundTask(taskId)
        }
        
        if taskId == UIBackgroundTaskInvalid {
            print("Failed to start background task!")
            return
        }
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { () -> Void in
            print("Starting background task with " + "\(app.backgroundTimeRemaining)s remaining")
            self.smiley = nil
            self.smileyView.image = nil
            NSThread.sleepForTimeInterval(10)
            print("Finishing background task with " + "\(app.backgroundTimeRemaining)s remaining")
            app.endBackgroundTask(taskId)
        }
    }
    func applicationWillEnterForeground() {
        print("\(__FUNCTION__)--VC")
        smiley = UIImage(named: "smiley")
        smileyView.image = smiley
    }
    func selectionChanged(sender: UISegmentedControl) {
        segementIndex = segementedControl.selectedSegmentIndex
    }
    //////
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

