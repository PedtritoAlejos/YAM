//
//  SettingFactory.swift
//  JAM
//
//  Created by pealejosb on 23-09-21.
//

import Foundation
import Combine


final class SettingFactory : ObservableObject {
    
    @Published var defaults: UserDefaults
    
    init(defaults: UserDefaults = .standard){
        self.defaults = defaults
        
        defaults.register(defaults: [
            "app.view.settings.order":0,
            "app.view.settings.showFavoriteOnly" :false
        
        ])
    }
    
    var order:SortingOrderType {
        get{
            SortingOrderType(type: defaults.integer(forKey:  "app.view.settings.order")  )
        }
        set{
            defaults.set(newValue.rawValue,forKey: "app.view.settings.order")
        }
    }
    var showFavoriteOnly:Bool {
        get{
            defaults.bool(forKey:  "app.view.settings.showFavoriteOnly")
        }
        
        set{
            defaults.set(newValue,forKey: "app.view.settings.showFavoriteOnly" )
        }
    }
    
}
