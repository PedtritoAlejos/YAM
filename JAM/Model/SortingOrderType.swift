//
//  SortingOrderType.swift
//  JAM
//
//  Created by pealejosb on 23-09-21.
//

import Foundation

enum SortingOrderType : Int , CaseIterable {
    case alphabetical = 0
    case favorite = 1
    case hours = 2
    
    init(type:Int ){
        switch type {
        case 0:
            self = .alphabetical
        case 1:
            self = .favorite
        case 2:
            self = .hours
        default:
            self = .alphabetical
        }
    }
    
    var description : String {
        switch self {
        case .alphabetical:
            return "Alfabéticamente"
        case .favorite:
            return "Favoritos"
        case .hours:
            return "Horas"
        
        }
    }
    
    func predicateSort() -> ( (ProyectoViewModel,ProyectoViewModel) -> Bool ){
        switch self {
        case .alphabetical:
            return { $0.nombre < $1.nombre }
        case .favorite:
            return {$0.favorito && !$1.favorito}
        case .hours:
            return {$0.numerohoras > $1.numerohoras}
        
        }
    }
}



