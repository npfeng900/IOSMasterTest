//
//  MasterViewController.swift
//  Presidents
//
//  Created by Niu Panfeng on 9/29/16.
//  Copyright © 2016 NaPaFeng. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var presidents: [[String : String]]!//var objects = [AnyObject]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let path = NSBundle.mainBundle().pathForResource("PresidentList", ofType: "plist")!
        let presidentInfo = NSDictionary(contentsOfFile: path)!
        presidents = presidentInfo["presidents"]! as! [NSDictionary] as! [[String:String]]
     
        // 如果分割试图存在
        if let split = self.splitViewController {
            let controllers = split.viewControllers//导航视图控制器数组，本例中有2个导航视图控制器
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController  //确保最上层的VC转化为detailViewController
        }
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed //是否显示，true为不显示，这里在willAppear时总为false
        super.viewWillAppear(animated)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

  
    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = presidents[indexPath.row]
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                
                if let oldContrller = detailViewController
                {
                    controller.languageString = oldContrller.languageString
                }
                
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
                
                detailViewController = controller
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presidents.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let president = presidents[indexPath.row]
        cell.textLabel?.text = president["name"]
        return cell
    }
    
}

