//
//  ViewController.swift
//  Persistence Core Data
//
//  Created by Niu Panfeng on 10/11/2016.
//  Copyright © 2016 NaPaFeng. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet var lineFields: [UITextField]!
    private let lineEntityName = "Line"
    private let lineNumberKey = "lineNumber"
    private let lineTextKey = "lineText"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
        let request = NSFetchRequest(entityName: lineEntityName)
        
        let objects = try? context.executeFetchRequest(request)
        if let objectList = objects
        {
            for objectOne in objectList
            {
                let lineNum = objectOne.valueForKey(lineNumberKey)!.integerValue
                let lineText = objectOne.valueForKey(lineTextKey) as! String
                lineFields[lineNum].text = lineText
            }
        }
        else
        {
            print("There was an error!")
        }
        
        //////
        let app = UIApplication.sharedApplication()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "applicationWillResignActive:", name: UIApplicationWillResignActiveNotification, object: app)
        
    }

    func applicationWillResignActive(notification : NSNotification){
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
        let request = NSFetchRequest(entityName: lineEntityName)
        
        for var i = 0; i<lineFields.count; i++
        {
            
            let pred = NSPredicate(format: "%K = %d", lineNumberKey, i)
            request.predicate = pred
            let objects = try? context.executeFetchRequest(request)
            
            var theLine: NSManagedObject! = nil
            
            if let objectList = objects
            {
                if objectList.count > 0
                {
                    theLine = objectList[0] as! NSManagedObject
                }
                else
                {
                    theLine = NSEntityDescription.insertNewObjectForEntityForName(lineEntityName, inManagedObjectContext: context) as NSManagedObject
                }
                
                theLine.setValue(i, forKey: lineNumberKey)
                theLine.setValue(lineFields[i].text, forKey: lineTextKey)
            }
            else
            {
                print("There was an error!")
            }
            
        }
        appDelegate.saveContext()
    }


}

