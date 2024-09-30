//
//  Little_LemonApp.swift
//  Little Lemon
//
//  Created by Youssef Al-Hassan on 29/09/2024.
//

import SwiftUI

@main
struct Little_LemonApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            Onboarding()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
