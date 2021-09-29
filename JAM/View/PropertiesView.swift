//
//  PropertiesView.swift
//  JAM
//
//  Created by pealejosb on 21-09-21.
//

import SwiftUI

struct PropertiesView: View {
    var project : ProyectoViewModel
    
    var body: some View {
        
        VStack{
        
                PropertiesDetailView(
                    title: "Horas estimadas",
                    subtitle: "VALOR HORA $\(intToCurrencyString(param_price:  self.project.valorhora))",
                    number: "\(self.project.horaestimada)",
                    textColor: Color(.white),
                    textColorSubtitle: Color(.white),
                    backgroundColor: Color("azul-pastel" )
                )
                    .padding()
          
            
            PropertiesDetailView(
                title: "Horas actuales",
                subtitle: "VALOR HORA $\(intToCurrencyString(param_price:  self.project.valorhora))",
                number: "\(self.project.numerohoras)",
                textColor: Color(.white),
                textColorSubtitle: Color(.white),
                backgroundColor: Color("morado-pastel"))
                .padding()
            
            PropertiesDetailView(
                title: "Monto actual",
                subtitle: "VALOR HORA $\(intToCurrencyString(param_price:  self.project.valorhora))",
                number: "$\(  intToCurrencyString(param_price: self.project.valorhora  * self.project.numerohoras) )",
                textColor: Color(.white),
                textColorSubtitle: Color(.white),
                backgroundColor: Color("indigo"))
                .padding()
            
        }.padding(.bottom ,100)
        
        
        
    }
}
/*
struct PropertiesView_Previews: PreviewProvider {
    
    @State  static var proyecto =  Project(name: "Formulario de contactos",
                                                 description: "Creación de formularios con datos cargados, debe validar un ticket valido",
                                                 image: "d2",
                                                 hour_value: 7500,
                                                 number_hours: 20,
                                                 type: "FRONTEND"
                                                 ,favorite: true)
    
    
    
    static var previews: some View {
        
        
        
        PropertiesView(project:  )
    }
}*/

struct PropertiesDetailView : View {
    var title :String
    var subtitle :String
    var number:String
    var textColor:Color
    var textColorSubtitle:Color
    var backgroundColor:Color
 
   
    
    var body: some View{
        VStack{
            
                       
            Text(title)
                .font(.system(.subheadline,design: .rounded))
                .fontWeight(.black)
                .foregroundColor(textColor)
            
            Text(number)
                .font(.system(size: 30,weight: .heavy,design: .rounded))
                .foregroundColor(textColor)
            
            Text(subtitle)
                .font(.system(.footnote,design: .rounded))
                .foregroundColor(textColorSubtitle)
                .fontWeight(.black)
                .padding(4)
                .background(Color( red:240/255 ,green:180/255,blue:50/255))
               
                .cornerRadius(8)
        }
        .frame( minWidth:0,maxWidth: .infinity,minHeight: 100 )
        .padding(20)
        .background(backgroundColor)
        .cornerRadius(10)
        
        
    }
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


