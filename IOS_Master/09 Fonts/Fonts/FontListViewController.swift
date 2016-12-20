//
//  FontListViewController.swift
//  Fonts
//
//  Created by Niu Panfeng on 9/14/16.
//  Copyright © 2016 NaPaFeng. All rights reserved.
//

import UIKit

class FontListViewController: UITableViewController {
    
    var fontNames: [String] = []
    var cellPointSize: CGFloat!
    var showsFavorites: Bool = false
    private let cellIdentifier = "FontName"

    override func viewDidLoad() {
        super.viewDidLoad()

        let perferredTableViewFont = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        cellPointSize = perferredTableViewFont.pointSize
        
        //右上角显示edit按钮
        if showsFavorites
        {
            navigationItem.rightBarButtonItem = editButtonItem()
        }

    }

    func fontForDisplay(atIndexPath indexPath: NSIndexPath) -> UIFont{
        
        let fontName = fontNames[indexPath.row]
        return UIFont(name: fontName, size: cellPointSize)!
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if showsFavorites
        {
            fontNames = FavoritesList.sharedFavoritesList.favorites
            tableView.reloadData()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let tableViewCell = sender as! UITableViewCell
        let indexPath = tableView.indexPathForCell(tableViewCell)!
        let font = fontForDisplay(atIndexPath: indexPath)
        
        if segue.identifier == "ShowFontSizes"
        {
            let sizeVC = segue.destinationViewController as! FontSizesViewController
            sizeVC.title = font.fontName
            sizeVC.font = font
        }
        else
        {
            let infoVC = segue.destinationViewController as! FontInfoViewController
            infoVC.font = font
            infoVC.favorite = FavoritesList.sharedFavoritesList.favorites.contains(font.fontName)
        }
        
    }

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fontNames.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        cell.textLabel?.font = fontForDisplay(atIndexPath: indexPath)
        cell.textLabel?.text = fontNames[indexPath.row]
        cell.detailTextLabel?.text = fontNames[indexPath.row]
       
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return showsFavorites
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if !showsFavorites
        {
            return
        }
        
        if editingStyle == UITableViewCellEditingStyle.Delete
        {
            let favarite = fontNames[indexPath.row]
            FavoritesList.sharedFavoritesList.removeFavorite(favarite)
            fontNames = FavoritesList.sharedFavoritesList.favorites
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        }
    }
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        FavoritesList.sharedFavoritesList.moveItem(fromIndex: sourceIndexPath.row, toIndex: destinationIndexPath.row)
        fontNames = FavoritesList.sharedFavoritesList.favorites
    }
 


}
