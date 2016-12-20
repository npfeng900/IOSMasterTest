//
//  ViewController.swift
//  PinchMe
//
//  Created by Niu Panfeng on 22/11/2016.
//  Copyright © 2016 NaPaFeng. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UIGestureRecognizerDelegate{
    
    private var imageView: UIImageView!
    private var scale: CGFloat = 1
    private var scalePrevious: CGFloat = 1
    private var rotation: CGFloat = 0
    private var rotationPrevious: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let image = UIImage(named: "yosemite-meadows")
        imageView = UIImageView(image: image)
        imageView.userInteractionEnabled = true
        imageView.center = view.center
        view.addSubview(imageView)
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: "doPinch:")
        pinchGesture.delegate = self
        imageView.addGestureRecognizer(pinchGesture)
        
        let rotationGesture = UIRotationGestureRecognizer(target: self, action: "doRotate:")
        rotationGesture.delegate = self
        imageView.addGestureRecognizer(rotationGesture)
    }

    func transformImageView() {
        var t = CGAffineTransformMakeScale(scale*scalePrevious, scale*scalePrevious)
        t = CGAffineTransformRotate(t, rotation + rotationPrevious )
        imageView.transform = t
    }
    
    func doPinch(gesture: UIPinchGestureRecognizer) {
        scale = gesture.scale
        transformImageView()
        if gesture.state == .Ended
        {
            scalePrevious = scale * scalePrevious
            scale = 1
        }
    }
    func doRotate(gesture: UIRotationGestureRecognizer) {
        rotation = gesture.rotation
        transformImageView()
        if gesture.state == .Ended
        {
            rotationPrevious = rotation + rotationPrevious
            rotation = 0
        }
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    


}

