//
//  ViewController.swift
//  Swipes
//
//  Created by Niu Panfeng on 21/11/2016.
//  Copyright © 2016 NaPaFeng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        for var touchCount = 1; touchCount <= 5; touchCount++
        {
            let vertiaclUp = UISwipeGestureRecognizer(target: self, action: "reportVerticalSwipe:")
            vertiaclUp.direction = UISwipeGestureRecognizerDirection.Up
            vertiaclUp.numberOfTouchesRequired = touchCount
            view.addGestureRecognizer(vertiaclUp)
            let vertiaclDown = UISwipeGestureRecognizer(target: self, action: "reportVerticalSwipe:")
            vertiaclDown.direction = UISwipeGestureRecognizerDirection.Down
            vertiaclDown.numberOfTouchesRequired = touchCount
            view.addGestureRecognizer(vertiaclDown)
            
            let horizontalLeft = UISwipeGestureRecognizer(target: self, action: "reportHorizontalSwipe:")
            horizontalLeft.direction = UISwipeGestureRecognizerDirection.Left
            horizontalLeft.numberOfTouchesRequired = touchCount
            view.addGestureRecognizer(horizontalLeft)
            let horizontalRight = UISwipeGestureRecognizer(target: self, action: "reportHorizontalSwipe:")
            horizontalRight.direction = UISwipeGestureRecognizerDirection.Right
            horizontalRight.numberOfTouchesRequired = touchCount
            view.addGestureRecognizer(horizontalRight)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func descriptionForTouchCount(touchCount: Int) -> String {
        switch touchCount{
        case 1:
            return "Single"
        case 2:
            return "Double"
        case 3:
            return "Triple"
        case 4:
            return "Quadruple"
        case 5:
            return "Quadruple"
        default:
            return ""
        }
    }
    func reportHorizontalSwipe(recognizer: UIGestureRecognizer) {
        let count = descriptionForTouchCount(recognizer.numberOfTouches())
        label.text = "\(count) Horizontal swipe detected"
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(2*NSEC_PER_SEC)), dispatch_get_main_queue()) { () -> Void in
            self.label.text = ""
        }
    }
    func reportVerticalSwipe(recognizer: UIGestureRecognizer) {
        let count = descriptionForTouchCount(recognizer.numberOfTouches())
        label.text = "\(count) Vertical swipe detected"
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(2*NSEC_PER_SEC)), dispatch_get_main_queue()) { () -> Void in
            self.label.text = ""
        }
    }


}

