//
//  DefaultsManager.swift
//  WatchInterface
//
//  Created by T. Andrew Binkowski on 5/18/15.
//  Copyright (c) 2015 The University of Chicago. All rights reserved.
//

import Foundation

/** To enable extension data sharing, we need to use an app group */
let sharedAppGroup: String = "group.mobi.uchicago.watchthis"

/** The key for our defaults storage */
let favoritesKey: String = "Favorite"


open class LocalDefaultsManager {
    open static let sharedInstance = LocalDefaultsManager()
    
    let sharedDefaults: UserDefaults?
    var favorites: NSMutableArray?
    
    init() {
        sharedDefaults = UserDefaults(suiteName: sharedAppGroup)
      let dir = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: sharedAppGroup)
      print("App Group Path: \(dir)")
        print(sharedDefaults?.dictionaryRepresentation() ?? "No defaults found")
    }
    
    open func add(object anObject: NSObject) {
        let current: NSMutableArray = currentList()
        current.add(anObject)
        sharedDefaults?.set(current, forKey: favoritesKey)
        sharedDefaults?.synchronize()
    }
    
    open func currentFavorite() -> String? {
        let current: NSMutableArray = currentList()
        return current.lastObject as? String
    }
    
    open func currentList() -> NSMutableArray {
        var current: NSMutableArray = []
        if let tempNames: NSArray = sharedDefaults?.array(forKey: favoritesKey) as? NSArray {
            current = tempNames.mutableCopy() as! NSMutableArray
        }
        return current
    }
    
    open func reset() {
        sharedDefaults?.set(NSMutableArray(), forKey: favoritesKey)
        sharedDefaults?.synchronize()
    }
}

