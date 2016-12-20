//
//  DoubleComponentPickerViewController.swift
//  Pickers
//
//  Created by Niu Panfeng on 8/20/16.
//  Copyright © 2016 NaPaFeng. All rights reserved.
//

import UIKit

class DoubleComponentPickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    let fillingComponent = 0
    let breadComponent = 1
    let fillingTypes = ["Ham", "Turkey", "Peanut Butter", "Tuna Salad", "Chiken Salad", "Roast Beef", "Vegemite"]
    let breadTypes = ["White", "Whole Wheat", "Rye", "Sourdough", "Seven Grain"]
    
    
    @IBOutlet weak var doublePicker: UIPickerView!
    
    @IBAction func buttonPressed(sender: UIButton) {
        
        let fillingRow = doublePicker.selectedRowInComponent(fillingComponent)
        let breadRow = doublePicker.selectedRowInComponent(breadComponent)
        let filling = fillingTypes[fillingRow]
        let bread = breadTypes[breadRow]
        
        let message = "Your \(filling) on \(bread) will be right up."
        let alert = UIAlertController(title: "Thank you for your order.", message: message, preferredStyle: .Alert)
        let action = UIAlertAction(title: "Great", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:-
    // MARK: Picker Data Source Methods
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == breadComponent
        {
            return breadTypes.count
        }
        else
        {
            return fillingTypes.count
        }
    }
    
    // MARK: Picker Delegate Methods
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == breadComponent
        {
            return breadTypes[row]
        }
        else
        {
            return fillingTypes[row]
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
