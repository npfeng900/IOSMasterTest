//
//  ViewController.swift
//  SlowWorker
//
//  Created by Niu Panfeng on 15/11/2016.
//  Copyright © 2016 NaPaFeng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var resultsTextView: UITextView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBAction func doWork(sender: UIButton) {
        let startTime = NSDate()
        self.resultsTextView.text = ""
        startButton.enabled = false
        spinner.startAnimating()
        
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        dispatch_async(queue) {
            
            let fetchData = self.fetchSomeingFromServer()
            let processdData = self.processData(fetchData)
            
            var firstResult: String!
            var secondResult: String!
            
            let group = dispatch_group_create()
            dispatch_group_async(group, queue) {
                firstResult = self.calculateFirstResult(processdData)
            }
            dispatch_group_async(group, queue) {
                secondResult = self.calculateSecondResult(processdData)
            }
            dispatch_group_notify(group, queue) {
                let resultSummary = "1:\(firstResult)\n2:\(secondResult)"
                dispatch_async(dispatch_get_main_queue()) {
                    self.resultsTextView.text = resultSummary
                    self.startButton.enabled = true
                    self.spinner.stopAnimating()
                }
                let endTime = NSDate()
                print("Completed in \(endTime.timeIntervalSinceDate(startTime)) seconds")
            }
            
            
            
        }
        
    }
    
    func fetchSomeingFromServer() -> String {
        NSThread.sleepForTimeInterval(1)
        return "I love you, baby!"
    }
    func processData(data: String) -> String {
        NSThread.sleepForTimeInterval(2)
        return data.uppercaseString
    }
    func calculateFirstResult(data: String) -> String {
        NSThread.sleepForTimeInterval(3)
        return "Number of chars: \(data.characters.count)"
    }
    func calculateSecondResult(data: String) -> String {
        NSThread.sleepForTimeInterval(4)
        return data.stringByReplacingOccurrencesOfString("E", withString: "e")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

