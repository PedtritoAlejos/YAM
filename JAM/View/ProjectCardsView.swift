//
//  ProjectCardsView.swift
//  JAM
//
//  Created by pealejosb on 22-09-21.
//

import SwiftUI

struct ProjectCardsView: View {
    
    @StateObject private var proyectoLVM = ProyectoListViewModel()
    
   
    @EnvironmentObject var settings : SettingFactory
    
    @State private var showProjectDetail = false
    @State private var selectedProyecto:ProyectoViewModel?
    @State private var showSettingView :Bool = false
    @State private var showProyectoAddView :Bool = false
    
    
   
   
    
    var body: some View {
        ZStack{
            
           
            
            NavigationView{
                List{
            
                    
                    ForEach ( self.proyectoLVM.proyectos
                                .filter(shouldShowProject)
                                .sorted(by: self.settings.order.predicateSort())
                              ,id:\.id ){ project in
                        
                        HStack{
                            Image(project.imagen)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 50, height: 50)
                                .cornerRadius(10)
                            VStack{
                                Text(project.nombre).frame(maxWidth: .infinity, alignment: .leading).font(.system(size: 17 ))
                                Text("Horas actuales \( project.numerohoras)")
                                    .frame(maxWidth: .infinity, alignment: .leading).font(.system(size: 13 )).foregroundColor(Color("color-description-rows"))
                                
                            }
                            
                            Spacer()
                            Image(systemName: project.favorito ? "star.fill" : "star").foregroundColor(
                                project.favorito ? Color("color-favorite") : Color(.black))
                        }.onTapGesture {
                            self.showProjectDetail = true
                            self.selectedProyecto = project
                        }
                        
                       /*BasicRow(project: proyecto)
                            .onTapGesture {
                                self.showProjectDetail = true
                                self.selectedProyecto = proyecto
                            }
                       */
                        
                    }.onDelete(perform: self.deleteProyecto)
                    
                }.navigationBarTitle("Mis proyectos")
                .navigationBarItems(
                    leading:
                        Button(action: {
                           
                            self.showProyectoAddView = true
                        }, label: {
                           Image(systemName: "plus")
                            .font(.title)
                            .foregroundColor(.black)
                        }
                            ).sheet(isPresented: $showProyectoAddView, content: {
                                ProyectoAddView().environmentObject(self.proyectoLVM)
                            })
                        ,
                    
                    trailing:
                         Button(action: {
                          self.showSettingView = true
                               }, label: {
                                        Image(systemName: "line.horizontal.3.decrease")
                                         .font(.title)
                                        .foregroundColor(.black)
                                        } ).sheet(isPresented: $showSettingView, content: {
                                            SettingsView().environmentObject(self.settings)
                                        })
                )
             
                
                
                
            }
            .onAppear(perform: {
                self.proyectoLVM.getAllProyecto()
            })
           .offset(y:self.showProjectDetail ? -150:0 )
           .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/(duration: 0.25))
            
            
            if showProjectDetail{
                BlankView(color: .gray).opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                    .onTapGesture {
                        self.showProjectDetail = false
                    }
                
                self.selectedProyecto.map{
                    ProjectDetailView(project:$0, isShown: $showProjectDetail)
                        .transition(.move(edge: .bottom)).environmentObject(proyectoLVM)
                }
            }
            
            
        }
    }
    
    private func shouldShowProject(project:ProyectoViewModel) -> Bool{
      
        let checkFavorite = (self.settings.showFavoriteOnly && project.favorito) || !self.settings.showFavoriteOnly
        

        return checkFavorite
    }
    private func deleteProyecto( at offsets :IndexSet ){
        offsets.forEach{ index in
            let proyecto = self.proyectoLVM.proyectos[index]
            self.proyectoLVM.delete(proyecto: proyecto)
        }
        self.proyectoLVM.getAllProyecto()
    }
    
    

}

struct ProjectCardsView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectCardsView()
            .environmentObject( SettingFactory() )
    }
}

struct BasicRow : View {
    var project:ProyectoViewModel
    
    var body: some View{
        
        HStack{
            Image(project.imagen)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 50, height: 50)
                .cornerRadius(10)
            VStack{
                Text(project.nombre).frame(maxWidth: .infinity, alignment: .leading).font(.system(size: 17 ))
                Text("Horas actuales \( project.numerohoras)")
                    .frame(maxWidth: .infinity, alignment: .leading).font(.system(size: 13 )).foregroundColor(Color("color-description-rows"))
                
            }
            
            Spacer()
            Image(systemName: project.favorito ? "star.fill" : "star").foregroundColor(
                project.favorito ? Color("color-favorite") : Color(.black))
        }
        
    }
}

struct BlankView :View{
    
    var color :Color
    
    var body: some View{
        VStack{
            Spacer()
                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/,  maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
                .background(color)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
        }
    }
}


