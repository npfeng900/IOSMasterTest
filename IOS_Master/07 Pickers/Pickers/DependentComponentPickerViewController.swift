//
//  DependentComponentPickerViewController.swift
//  Pickers
//
//  Created by Niu Panfeng on 8/20/16.
//  Copyright © 2016 NaPaFeng. All rights reserved.
//

import UIKit

class DependentComponentPickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    let stateComponent = 0
    let zipComponent = 1
    var stateZips:[String:[String]]!
    var states:[String]!
    var zips:[String]!
    
    @IBOutlet weak var dependentPicker: UIPickerView!
    
    
    @IBAction func buttonPressed(sender: UIButton) {
        let stateRow = dependentPicker.selectedRowInComponent(stateComponent)
        let zipRow = dependentPicker.selectedRowInComponent(zipComponent)
        let state = states[stateRow]
        let zip = zips[zipRow]
        
        let title = "You selected zip code \(zip)"
        let message = "\(zip) is in \(state)."
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // 加载视图后的操作
        let bundle = NSBundle.mainBundle()
        let plistURL = bundle.URLForResource("statedictionary", withExtension: "plist")
        stateZips = NSDictionary(contentsOfURL: plistURL!) as! [String:[String]]
        
        let allStates = stateZips.keys
        states = allStates.sort()
       
        //选定第一个州
        let selectedState = states[0]
        zips = stateZips[selectedState]
        
        // print(stateZips.keys)
        // print(allStates)
        // print(selectedState)
        // print(zips)
    
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
        if component == stateComponent
        {
            return states.count
        }
        else
        {
            return zips.count
        }
    }
    
    // MARK: Picker Delegate Methods
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == stateComponent
        {
            return states[row]
        }
        else
        {
            return zips[row]
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == stateComponent
        {
            let selectedState = states[row]
            zips = stateZips[selectedState]
            dependentPicker.reloadComponent(zipComponent)
            dependentPicker.selectRow(0, inComponent: zipComponent, animated: true)
            
        }
    }
    
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        let pickerWidth = pickerView.bounds.size.width
        if zipComponent == component
        {
            return pickerWidth/3
        }
        else
        {
            return pickerWidth*2/3
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
