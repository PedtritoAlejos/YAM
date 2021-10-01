//
//  ProyectoAddView.swift
//  JAM
//
//  Created by pealejosb on 26-09-21.
//

import SwiftUI
import Combine

struct ProyectoAddView: View {
    
    
    @State private var selectedTipo = TypeProyecto.backend
    
    @State private var isFavoriteProyecto : Bool = false
    @State private var imgeProyecto : String  = ""
    @State private var selectedTipoImagen = TypeImagen.d1
    
    @State private var  isMessageSave:Bool = false
    @State private var  messageProyecto:String = ""
    
    @State private var isValidForm:Bool = false
  
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var proyectoLVM :ProyectoListViewModel
    @ObservedObject private var registrationVM = RegistrationProyectoViewModel()

    var body: some View {
        
        NavigationView{
            Form{
                Section(header:Text("TIPO PROYECTO")){
                    Picker(selection: $selectedTipo, label: Text("Es de tipo"), content: {
                       
                        ForEach( TypeProyecto.allCases, id:\.self){ tipoProyecto in
                            Text(tipoProyecto.descripcionTipo)
                        }
                     })
                    
                    Toggle( isOn: $isFavoriteProyecto, label: {
                        Text("Marcar como favorito")
                    } )
                    
                }
               
                Section(header:Text("INGRESE NOMBRE Y DESCRIPCION") ){
                    
                    TextField("Ingrese un nombre",text: $registrationVM.nombre)
                    
                    ValidationFormView(
                        iconName:registrationVM.nombreLengthValid ? "checkmark.circle" : "xmark.circle",
                        iconColor: registrationVM.nombreLengthValid ? Color.green : Color.red ,
                        formText:"Nombre: Mínimo 3 caracteres",
                        conditionChecked: registrationVM.nombreLengthValid
                    )
                       
                    TextField("Ingrese una descripción",text:$registrationVM.descripcion)
                    
                    ValidationFormView(
                        iconName:registrationVM.descripcionLengthValid ? "checkmark.circle" : "xmark.circle",
                        iconColor: registrationVM.descripcionLengthValid ? Color.green : Color.red ,
                        formText:"Descripción: Mínimo 5 caracteres",
                        conditionChecked: registrationVM.descripcionLengthValid
                    )
                }
                
               
                
                Section(header:Text("VALOR HORA : $\(intToCurrencyString( param_price: Int(registrationVM.valorHora) ??  0 ) )")){
                    TextField("Ingrese valor hora",text: $registrationVM.valorHora)
                        .textContentType(.oneTimeCode)
                            .keyboardType(.numberPad)
                    
                       .onReceive(Just( registrationVM.valorHora ) ){ newValue in
                           
                           var filtered = newValue.filter { "0123456789".contains($0) }
                           
                           filtered = String( filtered.prefix(10))
                           
                           if filtered != newValue   {
                              
                               self.registrationVM.valorHora = filtered
                               
                            }
                        }
                    ValidationFormView(
                        iconName:registrationVM.valorHoraValid ? "checkmark.circle" : "xmark.circle",
                        iconColor: registrationVM.valorHoraValid ? Color.green : Color.red ,
                        formText:"Valor Hora: Máximo 10 dígitos",
                        conditionChecked: registrationVM.valorHoraValid
                    )
                }
                
                Section(header:Text("HORAS ESTIMADAS")){
                    TextField("Ingrese horas estimas",text: $registrationVM.horasEstimada)
                        .textContentType(.oneTimeCode)
                            .keyboardType(.numberPad)
                       
                        .onReceive(Just( registrationVM.horasEstimada ) ){ newValue in
                            var filtered = newValue.filter { "0123456789".contains($0) }
                            filtered = String( filtered.prefix(4))
                            
                            if filtered != newValue{
                                self.registrationVM.horasEstimada = filtered
                            }
                        }
                    ValidationFormView(
                        iconName:registrationVM.horasEstimadasValid ? "checkmark.circle" : "xmark.circle",
                        iconColor: registrationVM.horasEstimadasValid ? Color.green : Color.red ,
                        formText:"Valor Hora: Máximo 4 dígitos",
                        conditionChecked: registrationVM.horasEstimadasValid
                    )
                    
                }
                Section(header:Text("HORAS ACTUALES")){
                    TextField("Ingrese horas actuales",text: $registrationVM.horasActuales)
                        .textContentType(.oneTimeCode)
                            .keyboardType(.numberPad)
                        .onReceive(Just( registrationVM.horasActuales ) ){ newValue in
                            var filtered = newValue.filter { "0123456789".contains($0) }
                            filtered = String( filtered.prefix(4))
                            
                            if filtered != newValue {
                                
                                self.registrationVM.horasActuales = filtered
                            }
                        }
                    ValidationFormView(
                        iconName:registrationVM.horasActualesValid ? "checkmark.circle" : "xmark.circle",
                        iconColor: registrationVM.horasActualesValid ? Color.green : Color.red ,
                        formText:"Valor Hora: Máximo 4 dígitos",
                        conditionChecked: registrationVM.horasActualesValid
                    )
                    
                }
                Section(header :Text("Seleccione una imagen ")){
                    Picker(selection: $selectedTipoImagen, label: Text("Imagen"), content: {
                       
                        ForEach( TypeImagen.allCases, id:\.self){ imagen in
                            Text(imagen.descriptionImagen)
                        }
                    }).pickerStyle(.menu)
                    
                    ImagenVisualization(imagenName: selectedTipoImagen.nameImagen)
                }
                Section(header:Text("")){
                    Button( action: {
                        saveProyecto()
                    } ){
                        Text("GURADAR CAMBIOS")
                            .fontWeight(.bold)
                            .foregroundColor( self.registrationVM.validFullComplete ? .white : .white.opacity(0.5))
                            
                            .padding()
                            .cornerRadius(10)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .disabled(!registrationVM.validFullComplete)

                }.background( self.registrationVM.validFullComplete  ? Color(.black) : Color(.gray ))
                    .cornerRadius(10)
                   
                
            }.navigationBarTitle("Agregar Proyecto")
                .navigationBarItems(leading:
                                        Button(action: {
                                            self.presentationMode.wrappedValue.dismiss()
                                        }, label: {
                                            Image(systemName:"arrow.down.circle.fill")
                                                .font(.title)
                                                .foregroundColor(.gray)
                                        })
                )
        }.alert( isPresented: $isMessageSave){
            Alert( title: Text("Información"),message: Text(self.messageProyecto) ,dismissButton: .default(Text("Cerrar")))
        }
    }
    
    
    
    func saveProyecto(){
        self.proyectoLVM.tipo = self.selectedTipo.descripcionTipo
        self.proyectoLVM.favorito = self.isFavoriteProyecto
        self.proyectoLVM.nombre = self.registrationVM.nombre
        self.proyectoLVM.descripcion = self.registrationVM.descripcion
        self.proyectoLVM.valorhora = Int(self.registrationVM.valorHora) ?? 0
        self.proyectoLVM.horaestimada = Int(self.registrationVM.horasEstimada) ?? 0
        self.proyectoLVM.numerohoras = Int (self.registrationVM.horasActuales) ?? 0
        self.proyectoLVM.imagen = self.selectedTipoImagen.nameImagen
        
        self.proyectoLVM.save()
        self.proyectoLVM.getAllProyecto()
        
       
        self.isMessageSave = true
        self.messageProyecto = "Guardado Correntamente!"
        self.proyectoLVM.objectWillChange.send()
      
      
    }
    func intToCurrencyString( param_price:Int) -> String{
            let price = Double(param_price)
            let numberFormatter = NumberFormatter()
            numberFormatter.groupingSeparator = "."
            numberFormatter.groupingSize = 3
            numberFormatter.usesGroupingSeparator = true
            numberFormatter.decimalSeparator = ","
            numberFormatter.numberStyle = .decimal
            numberFormatter.maximumFractionDigits = 2
            return numberFormatter.string(from: price as NSNumber)!
        }
}

struct ImagenVisualization: View {
    var imagenName :String
    
    var body: some View {
        HStack{
            ZStack{
                GeometryReader { proxy in
                    Image(imagenName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: proxy.size.width )
                }
                
            } .clipped()
                .aspectRatio(1, contentMode: .fit)
                .clipShape(Circle())
                                .shadow(radius: 10)
                                .overlay(Circle().stroke(Color.gray, lineWidth: 0.5))
            
               
                
        }
    }
  
}

struct ProyectoAddView_Previews: PreviewProvider {
   
    static var previews: some View {
      
        ProyectoAddView().environmentObject(ProyectoListViewModel())
    }
}

struct ValidationFormView : View {
    
    var iconName = "xmark.circle"
    var iconColor = Color(red:0.9,green:0.5,blue:0.5)
    var formText = ""
    var conditionChecked = false
    
    var body: some View{
        HStack{
            Image(systemName: iconName )
                .foregroundColor(iconColor)
            Text(formText)
                .font(.system(.body,design: .rounded))
                .foregroundColor(.gray)
                .strikethrough(conditionChecked)
                
            
            
        }
    }
    
}
