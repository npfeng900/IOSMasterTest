//
//  DetailViewController.swift
//  TinyPix
//
//  Created by Niu Panfeng on 11/11/2016.
//  Copyright © 2016 NaPaFeng. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {


    @IBOutlet weak var pixView: TinyPixView!

    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if detailItem != nil && isViewLoaded()//这个很重要
        {
            pixView.document = detailItem! as! TinyPixDocument
            title = pixView.document.name
            pixView.setNeedsDisplay()
        }
    }

    private func updateTintColor() {
        let prefs = NSUserDefaults.standardUserDefaults()
        let selectedColorIndex = prefs.integerForKey("selectedColorIndex")
        let tintColor = TinyPixUtils.getTintColorForIndex(selectedColorIndex)
        pixView.tintColor = tintColor
        pixView.setNeedsDisplay()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
        updateTintColor()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onSettingsChanged:", name: NSUserDefaultsDidChangeNotification, object: nil)
    }
    
    func onSettingsChanged(notification: NSNotification) {
        updateTintColor()
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: NSUserDefaultsDidChangeNotification, object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        if let doc = detailItem as? UIDocument
        {
            doc.closeWithCompletionHandler(nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

