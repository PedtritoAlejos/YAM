//
//  ContentView.swift
//  JAM
//
//  Created by pealejosb on 20-09-21.
//

import SwiftUI

struct ContentView: View {
    
    @State var animate = false
    @State var endSPlash = false
    
    var body: some View {
        
        ZStack{
            
            ProjectCardsView().environmentObject(SettingFactory())
            
            ZStack{
                Color("indigo")
                
                VStack{
                    Image("logo")
                        .resizable()
                        .renderingMode(.original)
                      //  .aspectRatio( contentMode: animate ? .fill : .fit)
                        .frame(width: animate ? nil :  200, height: animate ? nil : 200)
                        
                    
                    Text("JAM")
                        .foregroundColor(.white)
                        .font( .title )
                        .bold()
               }
                
               
                
            }.edgesIgnoringSafeArea(.all)
                .onAppear(perform : {
                    animateSplash()
                })
                .opacity( endSPlash ? 0 : 1)
        }
        
       
    }
    func animateSplash(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.35 ){
            withAnimation( Animation.easeOut( duration: 1.65)) {
                animate.toggle()
            }
            
            withAnimation( Animation.easeIn( duration: 0.15)) {
                endSPlash.toggle()
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
