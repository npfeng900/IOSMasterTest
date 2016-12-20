//
//  DatePickerViewController.swift
//  Pickers
//
//  Created by Niu Panfeng on 8/20/16.
//  Copyright © 2016 NaPaFeng. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBAction func buttonPressed(sender: UIButton) {
        let date = datePicker.date
        let message = "The date and time you selected is \(date)"
        let alert = UIAlertController(title: "Date and Time Selected", message: message, preferredStyle: .Alert)
        let action = UIAlertAction(title: "That's so true!", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //加载视图，重置为当前时间
        let date = NSDate()
        datePicker.setDate(date, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
