//
//  Home.swift
//  Little Lemon
//
//  Created by Youssef Al-Hassan on 30/09/2024.
//

import SwiftUI

struct Home: View {
    let persistance = PersistenceController.shared
    var body: some View {
        TabView {
            Menu().tabItem {
                Label("Menu", systemImage: "list.dash")
            }.environment(\.managedObjectContext, persistance.container.viewContext)
            UserProfile().tabItem {
                Label("Profile", systemImage: "square.and.pencil")
            }
        }.navigationBarBackButtonHidden(true)
        
    }
}

#Preview {
    Home()
}
