//
//  ProjectDetailView.swift
//  JAM
//
//  Created by pealejosb on 21-09-21.
//

import SwiftUI

struct ProjectDetailView: View {
    
    @GestureState private var dragState = DragState.none
    
    @State private var offset: CGFloat = 0
    
    @State private var cardState = CardState.half
    
    var project: ProyectoViewModel
    @EnvironmentObject var proyectoLVM :ProyectoListViewModel
    
    @Binding var isShown : Bool
    @State var selectedView :Bool = true
 
    
    var body: some View {
        GeometryReader{ geometry in
            
            VStack {
            Spacer()
                HandleBar()
                
                TitleBar(detailText:"Detalle del Proyecto")
                
                TopBarDetailView(selected: $selectedView)
                
                if self.selectedView {
                    ScrollView(.vertical){
                        HeaderView(project: self.project)
                        
                        DescriptionView(
                            icon: "pin",
                            content:"\(self.project.nombre)"
                        ).padding(.bottom)
                        
                        DescriptionView(icon:nil,content: self.project.descripcion )
                            .padding(.bottom)
                        PropertiesView(project: self.project)
                    }
                    .animation(nil)
                    .disabled(false)
                }else{
                    ProyectoUpdateView( proyecto: self.project ).environmentObject(proyectoLVM)
                }
                
                
              
            }
            .background(Color("topBar"))
            .cornerRadius(15,antialiased: true)
            .offset(y:  geometry.size.height * 0.4 + self.dragState.translation.height + self.offset )
            .animation(.interpolatingSpring(stiffness: 500, damping: 500 , initialVelocity:10))
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            .gesture(DragGesture()
                        .updating( self.$dragState ){ (value,state,transaction) in
                            state = DragState.dragging(translation: value.translation)
                            
                            
                        }
                        .onEnded( { (value )in
                            switch self.cardState{
                            case .half:
                                // umbral superior, si es superado , transición ha estado full
                                if value.translation.height < -0.25 * geometry.size.height {
                                    self.offset = -0.5 * geometry.size.height  + (0.2 * geometry.size.height)
                                    self.cardState = .full
                                }
                                
                                // umbrar inferior, si es superior oculat la vista
                                if value.translation.height > 0.25 * geometry.size.height {
                                    self.isShown = false
                                }
                                
                                break
                            case .full :
                                // Umbral pequeño, si es superado transición a estado half
                                if value.translation.height > 0.25 * geometry.size.height {
                                    self.offset = 0
                                    self.cardState = .half
                                }
                                // Umbral  grande, si es superado, ocultar la tarjeta
                                if value.translation.height > 0.75 * geometry.size.height {
                                    self.isShown = false
                                }
                                
                                break
                            }
                            
                        } )
            )
            
        }
    }
}

/*
struct ProjectDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectDetailView( project: projects[0], isShown:.constant(true) )
            .background(Color.gray.opacity(0.5))
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}*/
