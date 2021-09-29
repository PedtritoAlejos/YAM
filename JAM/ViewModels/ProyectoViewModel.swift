//
//  ProyectoViewModel.swift
//  JAM
//
//  Created by pealejosb on 25-09-21.
//

import Foundation
import CoreData

class ProyectoListViewModel: ObservableObject {
    
    var nombre: String = ""
    var descripcion:String = ""
    var imagen:String = ""
    var valorhora:Int = 0
    var numerohoras:Int = 0
    var horaestimada:Int = 0
    var tipo:String = ""
    var favorito:Bool = false
    
   
    @Published var proyectos : [ProyectoViewModel] = []
    
    func delete( proyecto:ProyectoViewModel ){
        
        let existingProyecto = CoreDataManager.shared.getProyectoById(id: proyecto.id)
        
        if let existingProyecto = existingProyecto {
            CoreDataManager.shared.deleteProyecto(proyecto: existingProyecto)
        }
    }
    func update ( id:NSManagedObjectID, isFavorito:Bool, numeroHora:Int16){
        
        let existingProyecto = CoreDataManager.shared.getProyectoById(id: id)
        
        if let existingProyecto = existingProyecto {
            existingProyecto.favorito = isFavorito
            existingProyecto.numerohoras = numeroHora
            
            CoreDataManager.shared.save()
            
            
        }
    }
    
    func save(){
        let proyecto = Proyecto(context: CoreDataManager.shared.viewContext)
        
        proyecto.nombre = self.nombre
        proyecto.descripcion = self.descripcion
        proyecto.imagen = self.imagen
        proyecto.valorhora = Int64(self.valorhora)
        proyecto.numerohoras = Int16(self.numerohoras)
        proyecto.horaestimada = Int16(self.horaestimada)
        proyecto.favorito = self.favorito
        proyecto.tipo = self.tipo
        
        
        CoreDataManager.shared.save()
    }
    
    func getAllProyecto() {
        self.proyectos = CoreDataManager.shared.getAllProyecto().map( ProyectoViewModel.init )
    }
    
}

struct ProyectoViewModel  {
    let proyecto : Proyecto
    var id : NSManagedObjectID {
        return proyecto.objectID
    }
    
    var nombre:String{
        return proyecto.nombre ?? ""
    }
    var descripcion:String {
        return proyecto.descripcion ?? ""
    }
    var imagen:String {
        return proyecto.imagen ?? ""
    }
    var valorhora:Int {
        return Int(proyecto.valorhora)
    }
    var numerohoras:Int {
        return Int(proyecto.numerohoras)
    }
    var horaestimada:Int {
        return Int(proyecto.horaestimada)
    }
    var tipo:String {
        return proyecto.tipo ?? ""
    }
    var favorito:Bool {
        return proyecto.favorito
    }
    
    
    
    
}
