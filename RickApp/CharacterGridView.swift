//
//  CharacterGridView.swift
//  RickApp
//
//  Created by Angelo Chavez on 20/01/24.
//

import SwiftUI

struct CharacterGridView: View {
  
    @ObservedObject var viewModel = HomeViewModel()
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
            
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(viewModel.characters) { character in
                        NavigationLink(destination: CharacterDetailView(character: character)) {
                            CharacterGridItemView(character: character)
                        }
                    }
                }
                .padding()
            }
           
        .onAppear {
            viewModel.getCharacters()
        }
    }
}

#Preview {
    CharacterGridView()
}



//            .onAppear {
//                viewModel.getStories()
//            }





//
//
//
//
//
































//import SwiftUI
//import RickMortySwiftApi
//
//struct Story: Identifiable {
//    var id = UUID()
//    let character: RMCharacterModel
//
//    init(character: RMCharacterModel) {
//        self.character = character
//    }
//
//    var photoUrl: URL? {
//        // Convierte la cadena de la URL de la imagen a un objeto URL
//        return URL(string: character.image)
//    }
//
//    var title: String {
//        return character.name
//    }
//}
//
//
//
//struct StoriesView: View {
//    
//    @State private var story: [Story] = []
//
//    var body: some View {
//        ScrollView(.horizontal) {
//            
//            HStack (alignment: .top){
//                VStack{
//                    Image(profile.photo)
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 65)
//                    Text("Tu historia")
//                        .foregroundColor(.white)
//                        .bold()
//                }
//                
//                
//                ForEach(story) { story in
//                    VStack {
//                        if let url = story.photoUrl {
//                            AsyncImage(url: url) { image in
//                                image
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fill)
//                                    .clipShape(Circle())
//                                    .overlay(
//                                        Circle()
//                                            .stroke(LinearGradient(gradient: .init(colors: [Color.purple, Color.red, Color.orange]), startPoint: .topTrailing, endPoint: .topLeading), lineWidth: 4)
//                                    ).overlay(Circle().stroke(Color.black, lineWidth: 1))
//                            } placeholder: {
//                                ProgressView().background(.white)
//                            }.frame(width: 65, height: 65)
//                        } else {
//                            // Manejar el caso en que la URL de la imagen no sea válida
//                            Text("Imagen no disponible")
//                        }
//                        
//                        Text(story.title)
//                            .foregroundColor(.white)
//                            .frame(maxWidth: 65)
//                    }
//                }
//            }
//            .padding(.vertical, 4)
//            .padding(.horizontal, 5)
//            .background(.black)
//            .onAppear {
//                Task {
//                    await getStories()
//                }
//            }
//        }
//    }
//    func getStories() async {
//        do {
//            let rmClient = RMClient()
//            let characters = try await rmClient.character().getAllCharacters()
//            story = characters.map { Story(character: $0) }
//        } catch {
//            print(error)
//        }
//    }
//}
//
//struct StoriesView_Previews: PreviewProvider {
//    static var previews: some View {
//        StoriesView()
//    }
//}
