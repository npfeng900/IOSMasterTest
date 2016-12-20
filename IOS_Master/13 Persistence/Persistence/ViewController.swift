//
//  ViewController.swift
//  Persistence
//
//  Created by Niu Panfeng on 09/11/2016.
//  Copyright © 2016 NaPaFeng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var lineFields: [UITextField]!
    
    private let rootKey = "rootKey"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //读取数据
        
        let filePath = self.dataFilePath()
        if NSFileManager.defaultManager().fileExistsAtPath(filePath)
        {
           let array = NSArray(contentsOfFile: filePath) as! [String]
            for var i = 0; i < array.count; i++
            {
                lineFields[i].text = array[i]
            }
        }

        /*
        let filePath = self.dataFilePath()
        if NSFileManager.defaultManager().fileExistsAtPath(filePath)
        {
            //--声明一个归档类，对数据进行读取
            let data = NSMutableData(contentsOfFile: filePath)!
            let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
            //--读取归档的数据，并转化为支持NSCoding协议和NSCopying协议的类
            let fourLines = unarchiver.decodeObjectForKey(rootKey) as! FourLines
            unarchiver.finishDecoding()
            //--将数据复制给控件
            if let newLines = fourLines.lines
            {
                for var i = 0; i < newLines.count; i++
                {
                    lineFields[i].text = newLines[i]
                }
            }
        }
        */
        //添加监视器
        let app = UIApplication.sharedApplication()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "applicationWillResignActive:", name: UIApplicationWillResignActiveNotification, object: app)
    }
    
    func applicationWillResignActive(notification: NSNotification) {
        //存储数据
        
        let filePath = self.dataFilePath()
        let array = (self.lineFields as NSArray).valueForKey("text") as! NSArray
        array.writeToFile(filePath, atomically: true)

        
        /*
        let filePath = self.dataFilePath()
       
        //--声明一个归档类
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        //--获取控件中的数据
        let array = (self.lineFields as NSArray).valueForKey("text") as! [String]
        //--赋值给支持NSCoding协议和NSCopying协议的类，并进行编码归档
        let fourLines = FourLines()
        fourLines.lines = array
        //--
        archiver.encodeObject(fourLines, forKey: rootKey)
        archiver.finishEncoding()
        //--存储数据
        data.writeToFile(filePath, atomically: true)
        */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func dataFilePath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let documentsDirectory = paths[0] as String
        //
        return documentsDirectory.stringByAppendingString("data.plist") as String
        //
        //return documentsDirectory.stringByAppendingString("data.archive") as String
    }
   

    
}

