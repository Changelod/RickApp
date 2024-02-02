//
//  ContentView.swift
//  RickApp
//
//  Created by Angelo Chavez on 20/01/24.
//

import SwiftUI
import Combine

struct HomeView: View {
    @State private var showImage = true
    @StateObject var viewModel = HomeViewModel()

    var body: some View {
        NavigationView {
            ScrollView{
                VStack {
                    if showImage {
                        Image("RickLogo")
                            .resizable()
                            .scaledToFit()
                            .padding(10)
                        Spacer()
                    }
                    Text("Characters")
                        .font(.title)
                        .bold()
                    CharacterGridView(viewModel: viewModel)
                        .onTapGesture {
                            showImage = false
                        }
            }
                }.background(Color(red: 242/255, green: 240/255, blue: 230/255))
            }
            .onAppear {
                viewModel.getCharacters()
            }
    }
}

struct Character: Identifiable {
    var id = UUID()
    let character: CharacterInformationDTO

    var photoUrl: URL {
        return character.image
    }
    var title: String {
        return character.name
    }
    var gender: String {
        return character.gender
    }
    var species: String {
        return character.species
    }
    var status: String {
        return character.status
    }
//    
//    var origin: String {
//        return character.origin
//    }
//    
//    var location: String {
//        return character.location
//    }
//
}

class HomeViewModel: ObservableObject {
    @Published var characters: [Character] = []
    private var cancellables: Set<AnyCancellable> = []

    func getCharacters() {
        let url = URL(string: "https://rickandmortyapi.com/api/character")!
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: RickAndMortyResponseDTO.self, decoder: JSONDecoder())
            .map { $0.toModel() }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error)")
                }
            }, receiveValue: { [weak self] response in
                print("response \(response)")
                self?.characters = response
                self?.characters.forEach { print($0.character.origin.name)}
            })
            .store(in: &cancellables)
    }
}

struct RickAndMortyResponseDTO: Decodable {
    var results: [CharacterInformationDTO]

    func toModel() -> [Character] {
        return results.map { Character(character: $0) }
    }
}

struct CharacterInformationDTO: Decodable {
    var name: String
    var image: URL
    var gender: String
    var species: String
    var status: String
    var origin: OriginDTO
    var location: LocationDTO
}

struct LocationDTO: Decodable {
    var name: String
    var url: String
}

struct OriginDTO: Decodable {
    var name: String
    var url: String
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
