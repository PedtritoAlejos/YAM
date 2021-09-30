//
//  TopBarDetailView.swift
//  JAM
//
//  Created by pealejosb on 27-09-21.
//

import SwiftUI

struct TopBarDetailView: View {
   @Binding var selected: Bool
     
    
    var body: some View {
        VStack(){
            HStack{
                Button(action: {
                    
                    self.selected = true
                    
                } ){
                    Text("ver")
                        .fontWeight(.semibold)
                        .foregroundColor(self.selected ? Color("icon") : Color("icon").opacity(0.5))
                        .font(.system(.body ,design: .rounded))
                        .bold()
                    Image(systemName: "book")
                        .foregroundColor(self.selected ?  Color("icon") : Color("icon").opacity(0.5))
                    
                }.padding(.leading,35)
                Spacer()
                
                Button(action: {
                    self.selected = false
                } ){
                    Text("Editar")
                        .fontWeight(.semibold)
                        .foregroundColor(self.selected == false ? Color("icon") : Color("icon").opacity(0.5))
                        .font(.system(.body ,design: .rounded))
                        .bold()
                    Image(systemName: "square.and.pencil")
                        .foregroundColor(self.selected == false ? Color("icon") : Color("icon").opacity(0.5))
                        
                   
                }.padding(.trailing,35)
            }
        }
    }
}

/*
struct TopBarDetailView_Previews: PreviewProvider {
    static var previews: some View {
       
        TopBarDetailView(  )
    }
}
*/
