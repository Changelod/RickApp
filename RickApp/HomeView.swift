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
    @State private var lastOffset: CGFloat = 0

    var body: some View {
        NavigationView {
         
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
                        .gesture(DragGesture().onChanged { value in
                            let offsetY = value.translation.height
                            
                            // Se ejecuta cuando se detecta un cambio en el gesto de desplazamiento
                            if offsetY > 0 {
                                // Hacia abajo, ocultar la imagen
                                showImage = true
                            } else {
                                // Hacia arriba, mostrar la imagen
                                showImage = false
                            }
                        }.onEnded { value in
                            let offsetY = value.translation.height
                            
                            // Se ejecuta cuando se ha levantado el dedo después de desplazarse
                            if offsetY < 0 {
                                // Si el desplazamiento fue hacia arriba, mostrar la imagen
                                showImage = true
                            }
                        })
                    
                    
                    
                    
                    
                }
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
                self?.characters = response
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
//    var origin: String
//    var location: String
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}





