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
let kisLoggedIn = "isLoggedIn"

struct Onboarding: View {
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    @State var areEmpty: Bool = false
    @State var isLoggedIn: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink (destination: Home(), isActive: $isLoggedIn) {
                    EmptyView()
                }
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
                        UserDefaults.standard.set(true, forKey: kisLoggedIn)
                        isLoggedIn = true
                    }
                }, label: {
                    Label("Register", systemImage: "arrow.2.circlepath.circle")
                })
            }
            .alert("Please fill in all fields.", isPresented: $areEmpty) {
                Button("Ok", role: .cancel) {
                    areEmpty = false
                }
            }.onAppear() {
                if (UserDefaults.standard.bool(forKey: kisLoggedIn)) {
                    isLoggedIn = true
                }
            }
        }
    }
}

#Preview {
    Onboarding()
}
