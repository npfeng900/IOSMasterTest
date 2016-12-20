//
//  ViewController.swift
//  TapTaps
//
//  Created by Niu Panfeng on 22/11/2016.
//  Copyright © 2016 NaPaFeng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var singleLabel: UILabel!
    @IBOutlet weak var doubleLabel: UILabel!
    @IBOutlet weak var tripleLabel: UILabel!
    @IBOutlet weak var quadrupleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let singleTap = UITapGestureRecognizer(target: self, action: "singleTap")
        singleTap.numberOfTouchesRequired = 1
        singleTap.numberOfTapsRequired = 1
        view.addGestureRecognizer(singleTap)
        
        let doubleTap = UITapGestureRecognizer(target: self, action: "doubleTap")
        doubleTap.numberOfTouchesRequired = 1
        doubleTap.numberOfTapsRequired = 2
        view.addGestureRecognizer(doubleTap)
        singleTap.requireGestureRecognizerToFail(doubleTap)
        
        let tripleTap = UITapGestureRecognizer(target: self, action: "tripleTap")
        tripleTap.numberOfTouchesRequired = 1
        tripleTap.numberOfTapsRequired = 3
        view.addGestureRecognizer(tripleTap)
        doubleTap.requireGestureRecognizerToFail(tripleTap)
        
        let quadrupleTap = UITapGestureRecognizer(target: self, action: "quadrupleTap")
        quadrupleTap.numberOfTouchesRequired = 1
        quadrupleTap.numberOfTapsRequired = 4
        view.addGestureRecognizer(quadrupleTap)
        tripleTap.requireGestureRecognizerToFail(quadrupleTap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func singleTap() {
        singleLabel.text = "Single Tap Detected"
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(2*NSEC_PER_SEC)), dispatch_get_main_queue()) { () -> Void in
            self.singleLabel.text = ""
        }
    }
    func doubleTap() {
        doubleLabel.text = "Double Tap Detected"
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(2*NSEC_PER_SEC)), dispatch_get_main_queue()) { () -> Void in
            self.doubleLabel.text = ""
        }
    }
    func tripleTap() {
        tripleLabel.text = "Triple Tap Detected"
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(2*NSEC_PER_SEC)), dispatch_get_main_queue()) { () -> Void in
            self.tripleLabel.text = ""
        }
    }
    func quadrupleTap() {
        quadrupleLabel.text = "Quadruple Tap Detected"
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(2*NSEC_PER_SEC)), dispatch_get_main_queue()) { () -> Void in
            self.quadrupleLabel.text = ""
        }
    }

}

