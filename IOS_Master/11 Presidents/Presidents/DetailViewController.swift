//
//  DetailViewController.swift
//  Presidents
//
//  Created by Niu Panfeng on 9/29/16.
//  Copyright © 2016 NaPaFeng. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController , UIPopoverControllerDelegate {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var webView: UIWebView!
    
    private var languageButtonItem: UIBarButtonItem?
    private var languagePopoverController: UIPopoverController?
  
    //属性观察器
    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    var languageString: String = "" {
        didSet {
            if languageString != oldValue
            {
                configureView()
            }
            if let popoverController = languagePopoverController
            {
                popoverController.dismissPopoverAnimated(true)
                languagePopoverController = nil
            }
        }
    }
    //
    func toggleLanguagePopover(){
        if languagePopoverController == nil
        {
            let languageListController = LanguageListController()
            languageListController.detailViewController = self
            languagePopoverController = UIPopoverController(contentViewController: languageListController)
            languagePopoverController?.presentPopoverFromBarButtonItem(languageButtonItem!, permittedArrowDirections: .Any, animated: true)
        }
        else
        {
            languagePopoverController?.dismissPopoverAnimated(true)
            languagePopoverController = nil
        }
    }
    //点击其他的地方
    func popoverControllerDidDismissPopover(popoverController: UIPopoverController) {
        if popoverController == languagePopoverController
        {
            languagePopoverController = nil
        }
    }
    
    
    //更新DetialView的内容
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            if let label = self.detailDescriptionLabel {
                
                let president = detail as! [String:String]
                
                let urlString = modifyUrlForLanguage(url: president["url"]!, language: languageString)
                label.text = urlString
                let url = NSURL(string: urlString)!
                let request = NSURLRequest(URL: url)
                webView.loadRequest(request)
                
                let name = president["name"]
                title = name
            }
        }
    }
    
    //根据所选语言，修改url
    private func modifyUrlForLanguage(url url: String, language lang: String?) -> String {
        var newUrl = url
        
        if let langStr = lang
        {
            let range = NSMakeRange(7, 2)
            if !langStr.isEmpty && (url as NSString).substringWithRange(range) != langStr
            {
                newUrl = (url as NSString).stringByReplacingCharactersInRange(range, withString: langStr)
            }
        }
        
        return newUrl
    }
 
        
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad
        {
            languageButtonItem = UIBarButtonItem(title: "Choose Language", style: .Plain, target: self, action: "toggleLanguagePopover")
            navigationItem.rightBarButtonItem = languageButtonItem
        }
        
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

