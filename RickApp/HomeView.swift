//
//  ContentView.swift
//  RickApp
//
//  Created by Angelo Chavez on 20/01/24.
//

import SwiftUI

struct HomeView: View {
    @State private var showImage = true
//    @ObservedObject var viewModel = HomeViewModel()
var body: some View {
    NavigationView{
        VStack{
            if showImage {
                Image("RickLogo")
                    .scaledToFit()
                Spacer()
            }
            Image("")
                .resizable()
                .frame(width: 120, height: 120)
                .aspectRatio(contentMode: .fill)
                .foregroundColor(.blue)
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




