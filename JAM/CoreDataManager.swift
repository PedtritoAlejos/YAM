//
//  CoreDataManager.swift
//  JAM
//
//  Created by pealejosb on 25-09-21.
//

import Foundation
import CoreData

class CoreDataManager {
    let persistenContainer: NSPersistentContainer
    static let shared = CoreDataManager()
    
    var viewContext: NSManagedObjectContext {
        return persistenContainer.viewContext
    }
    
    
    private init() {
        persistenContainer = NSPersistentContainer(name: "ProjectAppModel")
        persistenContainer.loadPersistentStores{ (description,error) in
            if let error = error {
                fatalError("Unable to initialize Core Data Proyecto \(error)")
            }
        }
    }
    
    func getProyectoById(id: NSManagedObjectID) -> Proyecto? {
        do{
            return try viewContext.existingObject(with: id) as? Proyecto
        }catch{
            return nil
        }
    }
    
    func getAllProyecto() -> [Proyecto]{
        
        let request:NSFetchRequest<Proyecto> = Proyecto.fetchRequest()
        
        do{
            return try viewContext.fetch(request)
            
        }catch{
            return []
        }
    }
    
    func deleteProyecto( proyecto:Proyecto ){
        
        viewContext.delete(proyecto)
        save()
    }
    
    func save(){
        do{
            try viewContext.save()
            print("guardado desde core")
            
        }catch{
            print("ocurrio un error")
            viewContext.rollback()
            print(error.localizedDescription)
        }
    }
    
}
