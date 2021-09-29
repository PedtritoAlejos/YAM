//
//  HeaderView.swift
//  JAM
//
//  Created by pealejosb on 21-09-21.
//

import SwiftUI

struct HeaderView: View {
    
    var project : ProyectoViewModel
    
    var body: some View {
        Image(project.imagen )
            .resizable()
            .aspectRatio(contentMode: .fit)
            .overlay(
                HStack{
                    VStack(alignment: .center) {
                     
                        Text(project.nombre)
                            .foregroundColor(.white)
                            .font(.system(.title,design: .rounded))
                            .bold()
                            .padding()
                            .background(Color(.systemGray))
                            .cornerRadius(10)
                       
                        Text( project.tipo )
                            .font( .system( .subheadline,design: .rounded ) )
                            .bold()
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color.purple)
                            .cornerRadius(10)
                        
                        
                    }

                  
                }.padding()
                
            )
        
    }
}

/*struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView( project: projects[0] )
    }
}
*/
