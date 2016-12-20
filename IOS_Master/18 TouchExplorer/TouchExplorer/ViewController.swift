//
//  ViewController.swift
//  TouchExplorer
//
//  Created by Niu Panfeng on 21/11/2016.
//  Copyright © 2016 NaPaFeng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var tapLabel: UILabel!
    @IBOutlet weak var touchesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    private func updateLabels(touches: Set<UITouch>) {
        let numTaps = touches.first!.tapCount
        tapLabel.text = "\(numTaps) taps detected"
        
        let numTouches = touches.count
        touchesLabel.text = "\(numTouches) touches detected"
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        messageLabel.text = "Touches Began"
        updateLabels((event?.allTouches())!)
    }
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        messageLabel.text = "Touches Cancelled"
        updateLabels((event?.allTouches())!)
    }
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        messageLabel.text = "Touched Move"
        updateLabels((event?.allTouches())!)
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        messageLabel.text = "Touched End"
        updateLabels((event?.allTouches())!)
    }
}

