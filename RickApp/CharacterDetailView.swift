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
        VStack(){
            ZStack(alignment: .center) {
                       Circle()
                        .stroke(Color(getBackgroundColor(for: character.status)), lineWidth: 5)
                           .frame(width: 120, height: 120) // Ajusta el tamaño según tus necesidades
                           .overlay(Circle().stroke(Color(getBackgroundColor(for: character.status)), lineWidth: 1))
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
                       .frame(width: 120, height: 120)
                       .clipShape(Circle())
                Text(character.status)
                    .textCase(.uppercase)
                    .foregroundColor(Color.white)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    .frame(width: 60, height: 22)
                    .background(getBackgroundColor(for: character.status))
                    .cornerRadius(5.0)
                    .padding(.top, 120)
                    .fixedSize(horizontal: false, vertical: true)
                   }
                Text(character.title)
                .font(.title)
                .bold()

            Divider().opacity(0)
            VStack{
                Text("——— Properties ———")
                BarraDatos(title: "Gender", value: character.gender.capitalized)
                BarraDatos(title: "Species", value: character.species.capitalized)
                BarraDatos(title: "Status", value: character.status.capitalized)
                .padding(.bottom)
                Text("——— Whereabouts ———")
                BarraDatos(title: "Origin", value: character.gender.capitalized)
                BarraDatos(title: "Location", value: character.gender.capitalized)
                .padding(.bottom)
                Text("——— Featured Chapters ———")
                BarraDatos(title: "Chapter", value: character.gender.capitalized)
            }
            Spacer()
            .onAppear {
                       viewModel.getCharacters()
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 242/255, green: 240/255, blue: 230/255))
}
    
    struct BarraDatos: View {
        var title: String
        var value: String
        
        var body: some View {
            HStack{
            Text("\(title)")
                    .textCase(.uppercase)
                    .frame(width: 100, height: 30)
                    .background(Color(red: 228/255, green: 220/255, blue: 207/255))
                    .cornerRadius(6.0)
            Spacer()
            
            Text("\(value)")
                    .frame(width: 240, height: 30)
                    .background(Color(red: 237/255, green: 230/255, blue: 220/255))
                    .cornerRadius(6.0)
            }.padding(.horizontal)
        }
    }
    
    func getBackgroundColor(for status: String) -> Color {
        switch status.lowercased() {
        case "alive":
            return .green
        case "dead":
            return .red
        default:
            return .gray
        }
    }
}

#Preview {
    CharacterDetailView(character: Character(character: CharacterInformationDTO(name: "Rick", image: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")!, gender: "male" , species: "human", status: "UNKNOW", origin: OriginDTO(name: "test", url: "test"), location: LocationDTO(name: "test", url: "test"))))
}
