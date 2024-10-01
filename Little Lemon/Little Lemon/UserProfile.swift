//
//  UserProfile.swift
//  Little Lemon
//
//  Created by Youssef Al-Hassan on 30/09/2024.
//

import SwiftUI

struct UserProfile: View {
    let firstName = UserDefaults.standard.string(forKey: "firstName") ?? ""
    let lastName = UserDefaults.standard.string(forKey: "lastName") ?? ""
    let email = UserDefaults.standard.string(forKey: "email") ?? ""
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        VStack {
            Text("Personal Information")
            Image("profile-image-placeholder")
            Text("\(firstName) \(lastName)")
            Text(email)
            Button("Logout") {
                UserDefaults.standard.set(false, forKey: "isLoggedIn")
                presentation.wrappedValue.dismiss()
            }
            Spacer()
        }
    }
}

#Preview {
    UserProfile()
}
