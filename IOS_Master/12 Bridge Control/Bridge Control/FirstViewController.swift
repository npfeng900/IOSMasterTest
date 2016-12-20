//
//  FirstViewController.swift
//  Bridge Control
//
//  Created by Niu Panfeng on 08/11/2016.
//  Copyright © 2016 NaPaFeng. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var officerLabel: UILabel!
    @IBOutlet weak var authorizationCodeLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var warpDriveLabel: UILabel!
    @IBOutlet weak var warpFactorLabel: UILabel!
    @IBOutlet weak var favoriteTeaLabel: UILabel!
    @IBOutlet weak var favoriteCaptainLabel: UILabel!
    @IBOutlet weak var favoriteGadgetLabel: UILabel!
    @IBOutlet weak var favoriteAlienLabel: UILabel!
    
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
        
        officerLabel.text = defaults.stringForKey(officerKey)
        authorizationCodeLabel.text = defaults.stringForKey(authorizationCodeKey)
        rankLabel.text = defaults.stringForKey(rankKey)
        warpDriveLabel.text = defaults.boolForKey(warpDriveKey) ? "Yes" : "No"
        warpFactorLabel.text = defaults.objectForKey(warpFactorKey)?.stringValue
        favoriteTeaLabel.text = defaults.stringForKey(favoriteTeaKey)
        favoriteCaptainLabel.text = defaults.stringForKey(favoriteCaptainKey)
        favoriteGadgetLabel.text = defaults.stringForKey(favoriteGadgetKey)
        favoriteAlienLabel.text = defaults.stringForKey(favoriteAlienKey)
    }

    func applicationWillEnterForeground(notification : NSNotification) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.synchronize()
        refreshFields()
    }

}

