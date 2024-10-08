//
//  ProfileView.swift
//  expenseTracker
//
//  Created by Artiom Gramatin on 07.10.2024.
//

import SwiftUI
import SwiftData

struct ProfileView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var userProfiles: [UserProfile]
    
    @State private var inputName: String = ""
    @State private var inputBalance: String = "0"
    @State private var inputCurrency: String = "USD"
    @State private var isEditing: Bool = false
    
    let currencies = ["USD", "EUR", "MDL"]
    
    var body: some View {
        ScrollView {
            VStack {
                if let userProfile = userProfiles.first {
                    if isEditing {
                        Text("Edit Profile")
                            .font(.largeTitle)
                        
                        TextField("Enter your name", text: $inputName)
                            .textFieldStyle(.roundedBorder)
                            .padding(.horizontal)
                        
                        TextField("Enter your balance", text: $inputBalance)
                            .keyboardType(.decimalPad)
                            .textFieldStyle(.roundedBorder)
                            .padding(.horizontal)
                        
                        Picker("Select Currency", selection: $inputCurrency) {
                            ForEach(currencies, id: \.self) { currency in
                                Text(currency)
                            }
                        }
                        .pickerStyle(.segmented)
                        .padding()
                        
                        Button("Save") {
                            saveProfile(userProfile)
                            isEditing = false
                        }
                        .buttonStyle(.borderedProminent)
                        .padding()
                    } else {
                        VStack {
                            Text("Profile")
                                .font(.largeTitle)
                                .padding()
                            
                            Text("Name: \(userProfile.name)")
                            Text("Balance: \(userProfile.currency) \(userProfile.balance, specifier: "%.2f")")
                                .font(.headline)
                                .padding()
                            
                            Button("Edit Profile") {
                                isEditing = true
                                inputName = userProfile.name
                                inputBalance = "\(userProfile.balance)"
                                inputCurrency = userProfile.currency
                            }
                            .buttonStyle(.bordered)
                            .padding()
                        }
                    }
                } else {
                    Text("No profile found. Creating a default one...")
                        .onAppear {
                            createDefaultUserProfile()
                        }
                }
            }
            .onAppear {
                loadProfile()
            }
        }
    }
    
    private func createDefaultUserProfile() {
        if userProfiles.isEmpty {
            let newProfile = UserProfile(id: 0, name: "Default User", balance: 0.0, currency: "USD")
            modelContext.insert(newProfile)
            try? modelContext.save()
        }
    }
    
    private func loadProfile() {
        if let profile = userProfiles.first {
            inputName = profile.name
            inputBalance = "\(profile.balance)"
            inputCurrency = profile.currency
        }
    }
    
    private func saveProfile(_ profile: UserProfile) {
        profile.name = inputName
        profile.balance = Double(inputBalance) ?? 0.0
        profile.currency = inputCurrency
        try? modelContext.save()
    }
}

#Preview {
    ProfileView()
}
