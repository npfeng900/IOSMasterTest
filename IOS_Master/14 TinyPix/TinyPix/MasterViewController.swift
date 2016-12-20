//
//  MasterViewController.swift
//  TinyPix
//
//  Created by Niu Panfeng on 11/11/2016.
//  Copyright © 2016 NaPaFeng. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    @IBOutlet var colorControl: UISegmentedControl!
    private var documentFileNames: [String] = []
    private var chosenDocument: TinyPixDocument?
    
    var detailViewController: DetailViewController? = nil
    var objects = [AnyObject]()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        /*
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = addButton
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        */
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = addButton
        
        let prefs = NSUserDefaults.standardUserDefaults()
        let selectedColorIndex = prefs.integerForKey("selectedColorIndex")
        colorControl.selectedSegmentIndex = selectedColorIndex
        setTintColorForIndex(selectedColorIndex)
        
        reloadFiles()
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //弹出提示
    func insertNewObject(sender: AnyObject) {
        let alert = UIAlertController(title: "Create File Name", message: "Enter a name for your new TinyPix document", preferredStyle: .Alert)
        alert.addTextFieldWithConfigurationHandler(nil)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        let createAction = UIAlertAction(title: "Create", style: .Default) { (action) in
            let textField = alert.textFields![0] as UITextField
            self.createFileNamed(textField.text!)
        }
        
        alert.addAction(cancelAction)
        alert.addAction(createAction)
        
        presentViewController(alert, animated: true, completion: nil)
    }
    //根据文件名创建文件
    private func createFileNamed(fileName: String){
        let trimmedFileName = fileName.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        
        if trimmedFileName.isEmpty == false
        {
            let targetName = trimmedFileName + ".tinypix"
            let saveURL = urlForFileName(targetName)
            chosenDocument = TinyPixDocument(fileURL: saveURL)
            chosenDocument?.name = trimmedFileName
            chosenDocument?.saveToURL(saveURL, forSaveOperation: UIDocumentSaveOperation.ForCreating, completionHandler: { success in
                if success
                {
                    print("SaveCreate Ok!")
                    self.reloadFiles()
                    self.performSegueWithIdentifier("masterToDetail", sender: self)
                }else{
                    print("Failed to saveCreate!")
                }
            })
        }
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destination = segue.destinationViewController as! UINavigationController
        let detailVC = destination.topViewController as! DetailViewController
        
        if sender === self //segue.identifier == "masterToDetail"
        {
            detailVC.detailItem = chosenDocument
            print("masterToDetail")
        }
        else //if segue.identifier == "showDetail"
        {
            if let indexPath = self.tableView.indexPathForSelectedRow
            {
                let fileName = documentFileNames[indexPath.row]
                let docURL = urlForFileName(fileName)
                chosenDocument = TinyPixDocument(fileURL: docURL)
                chosenDocument?.name = (fileName as NSString).stringByDeletingPathExtension
                chosenDocument?.openWithCompletionHandler() { success in
                    if success
                    {
                        print("Load OK!")
                        detailVC.detailItem = self.chosenDocument
                        print("showDetail")
                    }
                    else
                    {
                        print("Failed to load!")
                    }
                }
                
                
            }
        }

    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return documentFileNames.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FileCell", forIndexPath: indexPath)
        let path = documentFileNames[indexPath.row] as NSString
        cell.textLabel!.text = NSString(string: path.lastPathComponent).stringByDeletingPathExtension
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            objects.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    //自定义函数
    //返回一个指向文件的URL指针
    private func urlForFileName(fileName: NSString) -> NSURL {
        let fm = NSFileManager.defaultManager()
        let urls = fm.URLsForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask) as [NSURL]
        let directoryURL = urls[0]
        let fileURL = directoryURL.URLByAppendingPathComponent(fileName as String)
        
        return fileURL
    }
    //加载应用沙盒中的Documents目录下的文件，并按升序排列
    private func reloadFiles() {
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true) as [String]
        let path = paths[0]//应用沙盒中的Documents目录
        
        let fm = NSFileManager.defaultManager()
        do {
            let files = try fm.contentsOfDirectoryAtPath(path) as [String]
            let sortedFileNames = files.sort({ (fileName1 : String, fileName2 : String) -> Bool in
                let file1Path = NSString(string: path).stringByAppendingPathComponent(fileName1)
                let file2Path = NSString(string: path).stringByAppendingPathComponent(fileName2)
                let attr1 = try? fm.attributesOfItemAtPath(file1Path)
                let attr2 = try? fm.attributesOfItemAtPath(file2Path)
                let file1Date = attr1![NSFileCreationDate] as! NSDate
                let file2Date = attr2![NSFileCreationDate] as! NSDate
                let result = file1Date.compare(file2Date)
                return result == NSComparisonResult.OrderedAscending
            })
            documentFileNames = sortedFileNames
            tableView.reloadData()
        }
        catch let error as NSError {
            print("Error listing files in directory \(path):\(error)")
        }
    }
    
    @IBAction func chooseColor(sender: UISegmentedControl) {
        let selectedColorIndex = sender.selectedSegmentIndex
        setTintColorForIndex(selectedColorIndex)
        //存储选择的颜色到用户默认设置
        let prefs = NSUserDefaults.standardUserDefaults()
        prefs.setInteger(selectedColorIndex, forKey: "selectedColorIndex")
        prefs.synchronize()
    }
    private func setTintColorForIndex(colorIndex: Int) {
        colorControl.tintColor = TinyPixUtils.getTintColorForIndex(colorIndex)
    }

}

