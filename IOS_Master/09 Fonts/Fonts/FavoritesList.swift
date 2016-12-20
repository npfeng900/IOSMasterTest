//
//  FavoritesList.swift
//  Fonts
//
//  Created by Niu Panfeng on 8/24/16.
//  Copyright © 2016 NaPaFeng. All rights reserved.
//

import Foundation
import UIKit

class FavoritesList{
    class var sharedFavoritesList: FavoritesList{
        struct Singleton {
            static let instance = FavoritesList()
        }
        return Singleton.instance
    }
    
    private(set) var favorites:[String]
    
    init(){
        let defaults = NSUserDefaults.standardUserDefaults()
        let storedFavorites = defaults.objectForKey("FAVORITES") as? [String]
        favorites = storedFavorites != nil ? storedFavorites! : []
    }
    func addFavorite(fontName: String){
        if !favorites.contains(fontName)
        {
            favorites.append(fontName)
            saveFavorites()
        }
    }
    func removeFavorite(fontName: String){
        if let index = favorites.indexOf(fontName)
        {
            favorites.removeAtIndex(index)
            saveFavorites()
        }
    }
    private func saveFavorites(){
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(favorites, forKey: "FAVORITES")
        defaults.synchronize()
    }
    
    func moveItem(fromIndex from: Int, toIndex to: Int){
        let item = favorites[from]
        favorites.removeAtIndex(from)
        favorites.insert(item, atIndex: to)
        saveFavorites()
    }
}