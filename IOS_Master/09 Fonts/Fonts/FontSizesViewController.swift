//
//  FontSizesViewController.swift
//  Fonts
//
//  Created by Niu Panfeng on 9/14/16.
//  Copyright © 2016 NaPaFeng. All rights reserved.
//

import UIKit

class FontSizesViewController: UITableViewController {

    var font: UIFont!
    private var pointSizes: [CGFloat]{
        get{
            struct Contants {
                static let ponitSizes: [CGFloat] = [9, 10, 11, 12, 13, 14, 18, 24, 36, 48 ,64, 72, 96, 144]
            }
            return Contants.ponitSizes
        }
    }
    private let cellIdentifier = "FontNameAndSize"
    
    
    func fontForDisplay(atIndexPath indexPath: NSIndexPath) -> UIFont{
        let pointSize = pointSizes[indexPath.row]
        return font.fontWithSize(pointSize)
    }
    
    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pointSizes.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        cell.textLabel?.font = fontForDisplay(atIndexPath: indexPath)
        cell.textLabel?.text = font.fontName
        cell.detailTextLabel?.text = "\(pointSizes[indexPath.row]) point)"
        return cell
    }

   
}
