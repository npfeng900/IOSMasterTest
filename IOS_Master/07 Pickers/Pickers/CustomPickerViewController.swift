//
//  CustomPickerViewController.swift
//  Pickers
//
//  Created by Niu Panfeng on 8/20/16.
//  Copyright © 2016 NaPaFeng. All rights reserved.
//

import UIKit
import AudioToolbox

class CustomPickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var images:[UIImage]!
    var winSoundID: SystemSoundID = 0
    var crunchSoundID: SystemSoundID = 0
    
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var winLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBAction func buttonPressed(sender: UIButton) {
        var win = false
        var numInRow = -1
        var lastValue = -1
        for i in 0..<5
        {
            let newValue = Int(arc4random_uniform(UInt32(images.count)))//生成一个0到images.count的随机整数
            if newValue == lastValue
            {
                numInRow++
            }
            else
            {
                numInRow = 1
            }
            lastValue = newValue
            
            picker.selectRow(newValue, inComponent: i, animated: true)
            picker.reloadComponent(i)
            if numInRow >= 3
            {
                win = true
            }
            
        }
        
        if crunchSoundID == 0
        {
            let soundURL = NSBundle.mainBundle().URLForResource("crunch", withExtension: "wav")! //as CFURLRef
            AudioServicesCreateSystemSoundID(soundURL, &crunchSoundID)
        }
        AudioServicesPlaySystemSound(crunchSoundID)
        
        if win
        {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(0.5*Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { () -> Void in
                self.playWinSound()
            }
        }
        else
        {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(0.5*Double(NSEC_PER_SEC))), dispatch_get_main_queue(), { () -> Void in
                self.showButton()
            })
        }
        
        button.hidden = true
        winLabel.text = " "
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        images = [
            UIImage(named: "seven")!,
            UIImage(named: "bar")!,
            UIImage(named: "crown")!,
            UIImage(named: "cherry")!,
            UIImage(named: "lemon")!,
            UIImage(named: "apple")!
        ]
        winLabel.text = ""
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:-
    // MARK: Picker Data Source Methods
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 5
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return images.count
    }
    
    // MARK: Picker Delegate Methods
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        let image = images[row]
        let imageView = UIImageView(image: image)
        return imageView
    }
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 64
    }
    // MARK:-
    func showButton(){
        button.hidden = false
    }
    func playWinSound(){
        if winSoundID == 0
        {
            let soundURL = NSBundle.mainBundle().URLForResource("win", withExtension: "wav")! as CFURLRef
            AudioServicesCreateSystemSoundID(soundURL, &winSoundID)
        }
        AudioServicesPlaySystemSound(winSoundID)
        winLabel.text = "WINNER"
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1.5*Double(NSEC_PER_SEC))), dispatch_get_main_queue()){ () -> Void in
            self.showButton()
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
