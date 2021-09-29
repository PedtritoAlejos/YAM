//
//  DescriptionView.swift
//  JAM
//
//  Created by pealejosb on 21-09-21.
//

import SwiftUI



struct DescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        DescriptionView(icon: "star", content: "hola")
    }
}

struct TitleBar :View {
    
    var detailText:String
    
    var body: some View{
        
        Text(detailText)
            .font(.headline)
            .foregroundColor(.primary)
            .padding()
    }
}

enum CardState {
    case half
    case full
    
}


struct HandleBar : View {
    var body: some View{
        Rectangle()
            .frame(width: 70, height: 7)
            .foregroundColor(Color(.systemGray4))
            .cornerRadius(8)
    }
}

struct DescriptionView : View {
    
    var icon:String?
    var content: String
    
    var body: some View{
        HStack{
            if icon != nil {
                Image(systemName: icon!)
                    .padding(.trailing,10)
                
            }
            Text(content)
                .font(.system(.body,design: .rounded))
            Spacer()
            
        }.padding(.horizontal)
        
    }
}
