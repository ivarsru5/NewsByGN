//
//  ContentView.swift
//  NewsByGN
//
//  Created by Ivars Ruģelis on 01/09/2021.
//

import SwiftUI

struct MainTabView: View {
    init(){
        UITabBar.appearance().barTintColor = UIColor.white
    }
    
    var body: some View {
        TabView{
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            NewsView()
                .tabItem {
                    Label("News", systemImage: "circle.grid.2x2")
                }
            
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "magnifyingglass")
                }
            
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "person")
                }
            
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "ellipsis.circle.fill")
                }
        }
        .accentColor(.orange)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
