//
//  ProyectoUpdateView.swift
//  JAM
//
//  Created by pealejosb on 27-09-21.
//

import SwiftUI

struct ProyectoUpdateView: View {
    @EnvironmentObject var proyectoLVM :ProyectoListViewModel
    var proyecto : ProyectoViewModel
  
    @State private var  isMessageSave:Bool = false
    @State private var  messageProyecto:String = ""
    
    @State private var isFavoriteProyecto : Bool = false
    @State private var maxHours = 500 {
           didSet{
               if maxHours > 500 {
                   maxHours = 500
               }
               
               if maxHours < 1 {
                   maxHours = 1
               }
           }
       }
    
    var body: some View {
        
        NavigationView{
            Form{
                Section(header:Text("")){
                    Toggle( isOn: $isFavoriteProyecto , label: {
                        Text("Marcar como favorito")
                    } )
                }
                Section(header:Text("AGREGAR O QUITAR HORAS")){
                    Stepper(onIncrement: { self.maxHours += 1  }, onDecrement: { self.maxHours -= 1
                                       }){  Text("Hora actual \(String( maxHours))")  }
                }
                Section(header:Text("")){
                    Button( action: {
                       
                        saveProyecto(proyecto:self.proyecto,isFavorito:self.isFavoriteProyecto,numeroHoras:Int16(self.maxHours) )
                    } ){
                        Text("GURADAR CAMBIOS") .fontWeight(.bold) .foregroundColor(.white)
                            .padding() .cornerRadius(10) .frame(maxWidth: .infinity, alignment: .center)
                    }

                }.background(Color(.black))
                    .cornerRadius(10)
                
                            
            }.navigationBarTitle(Text(proyecto.nombre), displayMode: .inline)
                .alert( isPresented: $isMessageSave){
                    Alert( title: Text("Información"),message: Text(self.messageProyecto) ,dismissButton: .default(Text("Cerrar")))
                    
        }.onAppear(perform: {
            self.isFavoriteProyecto = self.proyecto.favorito
            self.maxHours = self.proyecto.numerohoras
        })
       
         
    }
          
}
    func saveProyecto( proyecto : ProyectoViewModel , isFavorito:Bool , numeroHoras : Int16 ){
       
        
        self.proyectoLVM.update( id: proyecto.id , isFavorito:isFavorito , numeroHora: numeroHoras )
        self.proyectoLVM.getAllProyecto()
        self.isMessageSave = true
        self.messageProyecto = "Guardado Correntamente!"
        self.proyectoLVM.objectWillChange.send()
}
    
}

/*
struct ProyectoUpdateView_Previews: PreviewProvider {
    static var previews: some View {
    
        
        ProyectoUpdateView().environmentObject(ProyectoListViewModel())
    }
}
*/
