//
//  CharacterGridItem.swift
//  RickApp
//
//  Created by Angelo Chavez on 20/01/24.
//

import SwiftUI

struct CharacterGridItemView: View {
    var character: Character
    @ObservedObject var viewModel = HomeViewModel()
    
    var body: some View {
        ScrollView {
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
                        Text(character.status)
            
                }
            .padding()
        
        .onAppear {
            viewModel.getCharacters()
        }
        
    }
}


//struct CharacterGridItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        let characterInfoDTO = CharacterInformationDTO( name: "Rick", image: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")!)
//        let character = Character(character: characterInfoDTO)
//        
//        return CharacterGridItemView(character: character)
//            .padding()
//    }
//}

#Preview {
    CharacterGridItemView(character: Character(character: CharacterInformationDTO(name: "Rick", image: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")!, gender: "pro" , species: "pro", status: "alive")))
}


//struct ItemApi: Identifiable{
//    var id = UUID()
//    let photoUrl: URL
//    let title : String
//}
