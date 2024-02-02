//
//  RickAppApp.swift
//  RickApp
//
//  Created by Angelo Chavez on 20/01/24.
//

import SwiftUI

@main
struct RickAppApp: App {
    init() {
        // Configuración global para el color de fondo del TabBar
        UITabBar.appearance().barTintColor = UIColor(red: 242/255, green: 240/255, blue: 230/255, alpha: 1.0)
    }
    var body: some Scene {
        WindowGroup {
            TabBar()
        }
    }
}
