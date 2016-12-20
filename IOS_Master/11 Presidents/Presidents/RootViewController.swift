//
//  RootViewController.swift
//  Presidents
//
//  Created by Niu Panfeng on 08/11/2016.
//  Copyright © 2016 NaPaFeng. All rights reserved.
//

import UIKit

class RootViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //改变子视图的尺寸分类
    override func traitCollectionDidChange(previousTraitCollection: UITraitCollection?) {
        let splitVC = viewControllers[0] as UIViewController
        let newTraits = traitCollection
        if newTraits.horizontalSizeClass == .Compact && newTraits.verticalSizeClass == .Compact
        {
            let childTraits = UITraitCollection(horizontalSizeClass: .Regular)
            setOverrideTraitCollection(childTraits, forChildViewController: splitVC)
        }
        else
        {
            setOverrideTraitCollection(nil, forChildViewController: splitVC)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
