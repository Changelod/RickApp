//
//  ContentView.swift
//  RickApp
//
//  Created by Angelo Chavez on 20/01/24.
//

import SwiftUI

struct HomeView: View {
    @State private var showImage = true

var body: some View {
    NavigationView{
        VStack{
            if showImage {
                Image("RickLogo")
                    .scaledToFit()
                Spacer()
            }
            CharacterGridView()
                .onTapGesture {
                    showImage = false                }
            }
        }
    }
}

#Preview{
    HomeView()
}

