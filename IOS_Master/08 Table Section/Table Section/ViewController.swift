//
//  ViewController.swift
//  Table Section
//
//  Created by Niu Panfeng on 8/23/16.
//  Copyright © 2016 NaPaFeng. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let sectionsTableIdetifier = "SectionsTableIdentifier"
    var names: [String : [String]]!
    var keys: [String]!
    var searchController: UISearchController!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: sectionsTableIdetifier)
        let path = NSBundle.mainBundle().pathForResource("sortednames", ofType: "plist")
        let nameDict = NSDictionary(contentsOfFile: path!)
        names = nameDict as! [String : [String]]
        keys = names.keys.sort()
        
        //resultsController是一个结果显示控制器，自定义的
        let resultsController = SearchResultsController()
        resultsController.names = names
        resultsController.keys = keys
        
        //searchController是一个搜索控制器
        searchController = UISearchController(searchResultsController: resultsController)
        //searchBar是searchController的搜索栏
        let searchBar = searchController.searchBar
        searchBar.scopeButtonTitles = ["All", "Short", "Long"]
        searchBar.placeholder = "Enter a search term"
        searchBar.sizeToFit()
        
        searchController.searchResultsUpdater = resultsController
        
        tableView.tableHeaderView = searchBar
        tableView.sectionIndexBackgroundColor = UIColor.blackColor()
        tableView.sectionIndexTrackingBackgroundColor = UIColor.darkGrayColor()
        tableView.sectionIndexColor = UIColor.whiteColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: -
    //MARK: UITableViewDataSource Methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return keys.count
    }
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return keys[section]
    }
    func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        return keys
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = keys[section]
        let nameSection = names[key]!
        return nameSection.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       
      //两种赋值cell的方法
        let cell = tableView.dequeueReusableCellWithIdentifier(sectionsTableIdetifier)
      //let cell = tableView.dequeueReusableCellWithIdentifier(sectionsTableIdetifier, forIndexPath: indexPath)
        let key = keys[indexPath.section]
        let nameSection = names[key]!
        cell!.textLabel?.text = nameSection[indexPath.row]
        
        return cell!
    }
    

}

