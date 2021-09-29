//
//  TypeProyecto.swift
//  JAM
//
//  Created by pealejosb on 26-09-21.
//

import Foundation

enum TypeProyecto: Int , CaseIterable {
    
    case backend = 0
    case fronted = 1
    case etl = 2
    case db = 3
    case devops = 4
    case fullstack = 5
    case otros = 6
    
    init(type:Int ){
        
        switch type {
        case 0 :
            self = .backend
        case 1 :
            self = .fronted
        case 2 :
            self = .etl
        case 3 :
            self = .db
        case 4 :
            self = .devops
        case 5 :
            self = .fullstack
        case 6 :
            self = .otros
        default:
            self = .otros
        }
    }
    
    var descripcionTipo : String {
        
        switch self {
        case .backend :
            return "BACKEND"
        case .fronted :
            return "FRONTEND"
        case .db :
            return "DATABASE"
        case .devops :
            return "DEVOPS"
        case .fullstack :
            return "FULLSTACK"
        case .otros :
            return "OTROS"
        case .etl:
            return "ETL "
        
        }
        
    
    }
}
