//
//  SearchResultsController.swift
//  Table Section
//
//  Created by Niu Panfeng on 8/23/16.
//  Copyright © 2016 NaPaFeng. All rights reserved.
//

import UIKit

let longNameSize = 6
let shortNamesButtonIndex = 1
let longNamesButtonIndex = 2

class SearchResultsController: UITableViewController,UISearchResultsUpdating {

    let sectionsTableIdetifier = "SectionsTableIdentifier"
    var names: [String : [String]] = [String : [String]]()
    var keys: [String] = []
    var filteredNames: [String] = []
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: sectionsTableIdetifier)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
     
        
    }

    // MARK: - Update
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchString = searchController.searchBar.text!
        let buttonIndex  = searchController.searchBar.selectedScopeButtonIndex
        filteredNames.removeAll(keepCapacity: true)
        
        if searchString.isEmpty == false
        {
            let filter: String -> Bool =
            { (name:String) -> Bool in
                let nameLength = name.characters.count
                if (buttonIndex == shortNamesButtonIndex && nameLength >= longNameSize)
                    || (buttonIndex == longNamesButtonIndex && nameLength < longNameSize)
                {
                    return false
                }
                
                let range = name.rangeOfString(searchString, options: NSStringCompareOptions.CaseInsensitiveSearch)
                return range != nil
            }
            
            for key in keys
            {
                let namesForKey = names[key]!
                let matches = namesForKey.filter(filter)
                filteredNames += matches
            }
        }
        
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    /*
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    */
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filteredNames.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(sectionsTableIdetifier, forIndexPath: indexPath)
        cell.textLabel?.text = filteredNames[indexPath.row]
        return cell
    }
   
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
