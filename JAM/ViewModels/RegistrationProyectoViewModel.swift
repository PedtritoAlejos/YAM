//
//  RegistrationProyectoViewModel.swift
//  JAM
//
//  Created by pealejosb on 29-09-21.
//

import SwiftUI
import Combine

class RegistrationProyectoViewModel : ObservableObject {
    // Entrada de datos del usuario
    
    @Published var nombre = ""
    @Published var descripcion = ""
    @Published var valorHora :String = ""
    @Published var horasEstimada = ""
    @Published var horasActuales = ""
    
    // Valores de validación de formulario de creación de Proyecto
    
    @Published var nombreLengthValid : Bool = false
    @Published var descripcionLengthValid : Bool = false
    @Published var valorHoraValid : Bool = false
    @Published var horasEstimadasValid : Bool = false
    @Published var horasActualesValid : Bool = false
    
    @Published var validCompleteRegistration : Bool = false
    @Published var validFullComplete : Bool = false
    
    private var cancellableObject : Set<AnyCancellable> = []
    
    init() {
        $nombre
            .receive(on: RunLoop.main)
            .map { newNombre in
                return ( newNombre.count >= 3 )
                
            }
            .assign(to: \.nombreLengthValid,on:self)
            .store(in: &cancellableObject)
        
        $descripcion
            .receive(on:RunLoop.main)
            .map{ newDescripcion in
                return ( newDescripcion.count >= 5 )
                
            }
            .assign(to: \.descripcionLengthValid,on:self)
            .store(in:&cancellableObject)
        
        $valorHora
            .receive( on:RunLoop.main )
            .map{ newValorHora in
                return (newValorHora.count >= 1 && newValorHora.count <= 10)
            }
            .assign(to: \.valorHoraValid, on:self)
            .store(in:&cancellableObject)
        
        
        $horasEstimada
            .receive( on:RunLoop.main )
            .map{ newHorasEstimada in
                return ( newHorasEstimada.count >= 1 && newHorasEstimada.count <= 4 )
            }
            .assign(to: \.horasEstimadasValid, on:self )
            .store( in: &cancellableObject )
        
        $horasActuales
            .receive ( on:RunLoop.main )
            .map{ newHoraActuales in
                return (newHoraActuales.count >= 1 && newHoraActuales.count <= 4 )
            }
            .assign(to: \.horasActualesValid, on:self)
            .store(in: &cancellableObject)
        
        Publishers.CombineLatest4($nombreLengthValid,$descripcionLengthValid,$valorHoraValid,$horasEstimadasValid)
            .receive(on:RunLoop.main)
            .map{ (nombreLengthValid,descripcionLengthValid,valorHoraValid,horasEstimadasValid ) in
                return ( nombreLengthValid && descripcionLengthValid && horasEstimadasValid )
                
            }
            .assign(to: \.validCompleteRegistration,on:self)
            .store(in: &cancellableObject)

        Publishers.CombineLatest($validCompleteRegistration,$horasActualesValid)
            .receive(on:RunLoop.main)
            .map{ (validCompleteRegistration,horasActualesValid ) in
                return ( validCompleteRegistration && horasActualesValid  )
                
            }
            .assign(to: \.validFullComplete,on:self)
            .store(in: &cancellableObject)

        
    }
    
    
}
