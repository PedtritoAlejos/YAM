//
//  TypeImagen.swift
//  JAM
//
//  Created by pealejosb on 26-09-21.
//

import Foundation

enum TypeImagen : Int , CaseIterable {
    
    case d1 = 0
    case d2 = 1
    case laptoUno = 2
    case laptoDos = 3
    case laptoTres = 4
    case paisajeUno = 5
    case paisajeDos = 6
    case paisajeTres = 7
    
    init (type:Int){
        switch type {
        case 0 :
            self = .d1
        case 1 :
            self = .d2
        case 2 :
            self = .laptoUno
        case 3 :
            self = .laptoDos
        case 4 :
            self = .laptoTres
        case 5 :
            self = .paisajeUno
        case 6 :
            self = .paisajeDos
        case 7 :
            self = .paisajeTres
        default :
            self = .d1
        }
        
        
    }
    
    var descriptionImagen : String {
        switch self {
        case .d1:
            return "Consola"
        case .d2:
            return "Escritorio "
        case .laptoUno:
            return "Lapto Oscuro"
        case .laptoDos:
            return "Lapto Claro"
        case .laptoTres:
            return "Lapto Calido"
        case .paisajeUno:
            return "Invierno"
        case .paisajeDos:
            return "Otoño"
        case .paisajeTres:
            return "Verano"
        }
    }
    
    var nameImagen : String {
        switch self {
        case .d1:
            return "d1"
        case .d2:
            return "d2"
        case .laptoUno:
            return "lapto-1"
        case .laptoDos:
            return "lapto-2"
        case .laptoTres:
            return "lapto-3"
        case .paisajeUno:
            return "paisaje-1"
        case .paisajeDos:
            return "paisaje-2"
        case .paisajeTres:
            return "paisaje-3"
        }
    }
    
}
