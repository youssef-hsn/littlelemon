//
//  Onboarding.swift
//  Little Lemon
//
//  Created by Youssef Al-Hassan on 30/09/2024.
//

import SwiftUI

let kFirstName = "firstName"
let kLastName = "lastName"
let kEmail = "email"

struct Onboarding: View {
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    @State var areEmpty: Bool = false
    
    var body: some View {
        VStack {
            TextField("First Name", text: $firstName)
            TextField("Last Name", text: $lastName)
            TextField("Email", text: $email)
            Button(action: {
                if (firstName.isEmpty || lastName.isEmpty || email.isEmpty) {
                    areEmpty = true
                } else {
                    UserDefaults.standard.set(firstName, forKey: kFirstName)
                    UserDefaults.standard.set(lastName, forKey: kLastName)
                    UserDefaults.standard.set(email, forKey: kEmail)
                }
            }, label: {
                Label("Register", systemImage: "arrow.2.circlepath.circle")
            })
        }
        .alert("Please fill in all fields.", isPresented: $areEmpty) {
            Button("Ok", role: .cancel) {
                areEmpty = false
            }
        }
    }
}

#Preview {
    Onboarding()
}
