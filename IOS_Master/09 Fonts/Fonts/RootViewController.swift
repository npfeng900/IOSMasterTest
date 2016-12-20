//
//  RootViewController.swift
//  Fonts
//
//  Created by Niu Panfeng on 9/10/16.
//  Copyright © 2016 NaPaFeng. All rights reserved.
//

import UIKit

class RootViewController: UITableViewController {
    
    private var familyNames: [String]!
    private var cellPointSize: CGFloat!
    private var favoritesList: FavoritesList!//指向FavoritesList的单例
    private let familyCell = "FamilyCell"
    private let favoritesCell = "FavoritesCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        familyNames = UIFont.familyNames().sort() as [String]
        let perferredTableViewFont = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        cellPointSize = perferredTableViewFont.pointSize
        favoritesList = FavoritesList.sharedFavoritesList
        
        //删除字体家庭集中集体内容为空的字体家庭集
        for familyName in familyNames
        {
            if UIFont.fontNamesForFamilyName(familyName).first == nil
            {
                familyNames.removeAtIndex(familyNames.indexOf(familyName)!)
            }
        }
     }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()//因为RootViewController是UITableViewController的继承类，所以含有table
    }
    
    func fontForDisplay(atIndexPath indexPath: NSIndexPath) -> UIFont?{
        if indexPath.section == 0
        {
            let familyName = familyNames[indexPath.row]
            let fontName = UIFont.fontNamesForFamilyName(familyName).first!
            return UIFont(name: fontName, size: cellPointSize)
        }
        
        return nil
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)!
        let listVC = segue.destinationViewController as! FontListViewController
        
        if indexPath.section == 0
        {
            let familyName = familyNames[indexPath.row]
            listVC.fontNames = UIFont.fontNamesForFamilyName(familyName).sort()
            listVC.navigationItem.title = familyName
            listVC.showsFavorites = false
        }
        else
        {
            listVC.fontNames = favoritesList.favorites
            listVC.navigationItem.title = "Favorites"
            listVC.showsFavorites = true
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return favoritesList.favorites.isEmpty ? 1 : 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return section == 0 ? familyNames.count : 1
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "All Font Family" : "My Favorite Fonts"
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0
        {
            let cell = tableView.dequeueReusableCellWithIdentifier(familyCell, forIndexPath: indexPath)              
            cell.textLabel?.font = fontForDisplay(atIndexPath: indexPath)
            cell.textLabel?.text = familyNames[indexPath.row]
            cell.detailTextLabel?.text = familyNames[indexPath.row]
            return cell
        }
        // Configure the cell...
        else
        {
            return tableView.dequeueReusableCellWithIdentifier(favoritesCell, forIndexPath: indexPath)
        }
    }
    
}
