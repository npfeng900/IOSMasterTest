//
//  ViewController.swift
//  QuartzFun
//
//  Created by Niu Panfeng on 17/11/2016.
//  Copyright © 2016 NaPaFeng. All rights reserved.
//
//C模型

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var colorControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func changeColor(sender: UISegmentedControl) {
        if let drawingColor = DrawingColor(rawValue: UInt(sender.selectedSegmentIndex))
        {
            let funView = view as! QuartzFunView
            switch drawingColor {
            case .Red:
                funView.currentColor = UIColor.redColor()
                funView.useRandomColor = false
            case .Blue:
                funView.currentColor = UIColor.blueColor()
                funView.useRandomColor = false
            case .Yellow:
                funView.currentColor = UIColor.yellowColor()
                funView.useRandomColor = false
            case .Green:
                funView.currentColor = UIColor.greenColor()
                funView.useRandomColor = false
            case .Random:
                funView.currentColor = UIColor.randomColor()
                funView.useRandomColor = true
            }
        }
    }
    @IBAction func changeShape(sender: UISegmentedControl) {
        if let shape = Shape(rawValue: UInt(sender.selectedSegmentIndex))
        {
            let funView = view as! QuartzFunView
            funView.shape = shape
            colorControl.hidden = shape == Shape.Image
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

