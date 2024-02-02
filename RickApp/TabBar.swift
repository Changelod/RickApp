//
//  TabBar.swift
//  RickApp
//
//  Created by Angelo Pozo on 23/01/24.
//


import SwiftUI

struct TabBar: View {
    var body: some View {
        HStack{
            TabView {
                HomeView()
                    .tabItem {
                        Label("Characters", systemImage: "person")
                    }
                
                HomeView()
                    .tabItem {
                        Label("Locationsprueba", systemImage: "cat")
                    }
                
                HomeView()
                    .tabItem {
                        Label("Locations", systemImage: "dog")
                    }
               
            }
        }
    }
}

#Preview {
    TabBar()
}
