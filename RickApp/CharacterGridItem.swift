//
//  CharacterGridItem.swift
//  RickApp
//
//  Created by Angelo Chavez on 20/01/24.
//

import SwiftUI

struct CharacterItemView: View {
    var body: some View {
        HStack {
            VStack {
                // Assuming character.photoUrl is a URL
                // You may need to handle the URL loading separately, for example, using a library like SwiftUI-URLImage
                // URLImage(url: character.photoUrl)
                // Placeholder image for demonstration purposes
               Image("RickLogo")
                    
                    .frame(width: 120, height: 120)
                    .aspectRatio(contentMode: .fill)
                    .foregroundColor(.blue)

                Text("Hola")
                    .font(.system(size: 18.0))
                    .bold()
                    .foregroundColor(.black)
            }
            .padding()
        }
        .frame(maxWidth: .infinity)
        .background(Color.blue)
        .cornerRadius(11)
    }
}


#Preview {
    CharacterItemView()
}
