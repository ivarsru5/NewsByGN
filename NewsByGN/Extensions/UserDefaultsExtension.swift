//
//  UserDefaultsExtension.swift
//  NewsByGN
//
//  Created by Ivars Ruģelis on 06/09/2021.
//

import Foundation

extension UserDefaults{
    var searchHistory: [String]{
        get {
            array(forKey: "searchHistory") as? [String] ?? []
        }
        set{
            set(newValue, forKey: "searchHistory")
        }
    }
}
