//
//  MainView.swift
//  GerenciadorDeTreinos
//
//  Created by Luciano Puzer on 26/11/21.
//

import SwiftUI

struct PageController: View {
    @EnvironmentObject var mainViewModel: MainViewModel
    @EnvironmentObject var weekTrainingViewModel: WeekTrainingViewModel
    @State private var selection = 0
    
    init() {
        UITabBar.appearance().backgroundColor = .init(named: "TabBarBackground")
        UITabBar.appearance().unselectedItemTintColor = UIColor.black
    }
    
    var body: some View {
            TabView (selection: $selection){
                MainView()
                    .tabItem {
                        Image(systemName: "list.bullet.rectangle")
                        Text("Treinos")
                    }.tag(0)
                
                LoginView()
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("Conta")
                    }.tag(2)
            }.accentColor(.red)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        PageController()
            .preferredColorScheme(.dark)
            .environmentObject(MainViewModel())
            .environmentObject(WeekTrainingViewModel())
    }
}




struct weekDaysBorder: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .font(.title3)
            .frame(width: 60, height: 50)
            .background(Color("CellOrange"))
            .cornerRadius(50)
            .foregroundColor(Color.black)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.orange, lineWidth: 2)
            )
            .padding(.bottom, 30)
            .padding(.trailing, 30)
    }
}


struct weekTrainingBorder: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .font(.title3)
            .frame(width: 100, height: 50)
            .background(Color("CellBlue"))
            .cornerRadius(50)
            .foregroundColor(Color.black)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.blue, lineWidth: 3)
            )
            .padding(.bottom, 30)
    }
}
   
    
