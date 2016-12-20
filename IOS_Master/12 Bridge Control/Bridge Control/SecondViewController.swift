//
//  SecondViewController.swift
//  Bridge Control
//
//  Created by Niu Panfeng on 08/11/2016.
//  Copyright © 2016 NaPaFeng. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var engineSwitch: UISwitch!
    @IBOutlet weak var warpFactorSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        refreshFields()
        let app = UIApplication.sharedApplication()
         NSNotificationCenter.defaultCenter().addObserver(self, selector: "applicationWillEnterForeground:", name: UIApplicationWillEnterForegroundNotification, object: app)
    }
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refreshFields(){
        let defaults = NSUserDefaults.standardUserDefaults()
        engineSwitch.on = defaults.boolForKey(warpDriveKey)
        warpFactorSlider.value = defaults.floatForKey(warpFactorKey)
    }
    func applicationWillEnterForeground(notification : NSNotification) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.synchronize()
        refreshFields()
    }
    
    @IBAction func engineSwitchTapped(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(engineSwitch.on, forKey: warpDriveKey)
        defaults.synchronize()
    }
    @IBAction func warpSliderTouched(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setFloat(warpFactorSlider.value, forKey: warpFactorKey)
        defaults.synchronize()
    }
    @IBAction func settingButtonClicked(sender: UIButton) {
        UIApplication.sharedApplication().openURL(NSURL(string: UIApplicationOpenSettingsURLString)!)
    }

}

