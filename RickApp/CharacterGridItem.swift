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
            VStack(alignment: .center) {
                HStack(alignment: .center) {
                    AsyncImage(url: character.photoUrl) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
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
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))
                    VStack(alignment: .leading) {
                                      Text(character.title)
                                        .bold()
                                        .lineLimit(1)
                                        .minimumScaleFactor(0.5)                           .font(.title)
                                          .underline()
                                          .foregroundColor(Color.black)
                                          .padding(.trailing)
                                          .padding(.bottom)
                                          .fixedSize(horizontal: false, vertical: true)
                                      Text(character.species.uppercased())
                                          .foregroundColor(Color.black)
                                      HStack(alignment: .center, spacing:0) {
                                          Text("·")
                                              .bold()
                                              .font(.system(size: 50))
                                              .padding(.bottom, 5)
                                              .foregroundColor(character.status == "Alive" ? .green : (character.status == "Dead" ? .red : .gray))
                                          Text(character.status.capitalized)
                                              .lineLimit(1)
                                              .foregroundColor(Color.black)
                                          Spacer()
                                          Text(character.gender.lowercased() == "male" ? "♂" : (character.gender.lowercased() == "female" ? "♀" : "-"))
                            
                                              .bold()
                                              .foregroundColor(Color.black)
                                          Text(character.gender.capitalized)
                                              .foregroundColor(Color.black)
                                              .padding(.trailing, 60)
                                      }
                                  }.padding(.top)
                        .frame(maxWidth: .infinity, maxHeight: 120,  alignment: .leading)
                              }
                .background(Color(red: 228/255, green: 220/255, blue: 207/255))
                .cornerRadius(10.0)
                .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .onAppear {
            viewModel.getCharacters()
        }
    }
}

#Preview {
    CharacterGridItemView(character: Character(character: CharacterInformationDTO(name: "Rick", image: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")!, gender: "pro" , species: "pro", status: "alive", origin: OriginDTO(name: "test", url: "test"), location: LocationDTO(name: "test", url: "test") )))
}
