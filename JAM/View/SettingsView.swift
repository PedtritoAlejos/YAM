//
//  SettingsView.swift
//  JAM
//
//  Created by pealejosb on 23-09-21.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var settings : SettingFactory
    
    @State private var selectedOrder = SortingOrderType.alphabetical
    @State private var  showFavoriteOnly = false
    @Environment(\.presentationMode) var presentationMode
 
    var body: some View {
        
        NavigationView{

                Form {
                    
                    Section(header:Text("ORDENA TUS PROYECTOS")){
                        Picker(selection: $selectedOrder, label: Text("Ordena por"), content: {
                           
                            ForEach( SortingOrderType.allCases, id:\.self){ orderType in
                                Text(orderType.description)
                            }
                         })
                        
                    }
                    Section(header: Text("FILTRAR LOS CURSOS")){
                        Toggle( isOn: $showFavoriteOnly, label: {
                            Text("Mostrar solo favoritos")
                        } )
                    }
                    
                }
                .navigationBarTitle("Configuración")
                .navigationBarItems(
                    leading:
                                    Button(action: {
                                        self.presentationMode.wrappedValue.dismiss()
                                    }, label: {
                                        Image(systemName:"arrow.down.circle.fill")
                                            .font(.title)
                                            .foregroundColor(.gray)
                                    }),
                    trailing:
                    Button(action: {
                        
                        self.settings.order = self.selectedOrder
                        self.settings.showFavoriteOnly = self.showFavoriteOnly
                        self.settings.objectWillChange.send()
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName:"checkmark.circle.fill")
                            .font(.title)
                            .foregroundColor(.green)
                    })
                )
            }
            .onAppear(){
            self.selectedOrder = self.settings.order
            self.showFavoriteOnly = self.settings.showFavoriteOnly
            }
        }
}
//arrow.down.circle.fill
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView().environmentObject(SettingFactory())
    }
}
