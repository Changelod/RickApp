//
//  CharacterDetailView.swift
//  RickApp
//
//  Created by Luis Chavez pozo on 24/01/24.
//

import SwiftUI

struct CharacterDetailView: View {
    var character: Character
    @ObservedObject var viewModel = HomeViewModel()

    
    var body: some View {
        
        VStack {
            AsyncImage(url: character.photoUrl) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120, height: 120)
                        .foregroundColor(.blue)
                case .failure:
                    Text("Failed to load image")
                        .foregroundColor(.red)
                @unknown default:
                    Text("Unknown state")
                        .foregroundColor(.red)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))
            .padding(8)

            Text(character.title)
            Text(character.gender)
            Text(character.species)
            Text(character.status)
 
            
            
            
            
            
            
            
        }
        .onAppear {
            viewModel.getCharacters()
        }
    }
}

#Preview {
    CharacterDetailView(character: Character(character: CharacterInformationDTO(name: "Rick", image: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")!, gender: "male" , species: "human", status: "alive", origin: OriginDTO(name: "test", url: "test"), location: LocationDTO(name: "test", url: "test"))))
}
