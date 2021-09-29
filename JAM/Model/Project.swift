//
//  Project.swift
//  JAM
//
//  Created by pealejosb on 20-09-21.
//

import Foundation

struct Project : Identifiable {
    var id : UUID = UUID()
    var name :String
    var description:String
    var image :String
    var hour_value:Int
    var number_hours:Int
    var estimed_hours:Int
    var favorite:Bool
    var type:String

    
    init( name:String,description:String, image:String, hour_value:Int, number_hours:Int,type:String ,favorite:Bool){
        self.name = name
        self.description = description
        self.image = image
        self.hour_value = hour_value
        self.number_hours = number_hours
        self.estimed_hours = 0
        self.type = type
        self.favorite = favorite
    
    }
    
    init() {
        self.init(name: "", description: "", image: "", hour_value: 0, number_hours: 0, type:"",favorite:false)
        
    }
    
    
}


