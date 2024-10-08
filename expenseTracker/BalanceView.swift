//
//  BalanceView.swift
//  expenseTracker
//
//  Created by Artiom Gramatin on 07.10.2024.
//

import SwiftUI
import SwiftData

struct BalanceView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var userProfiles: [UserProfile]
    @State private var balanceInput: String = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    var body: some View {
        VStack {
            if let userProfile = userProfiles.first {
                Text("Balance")
                    .font(.largeTitle)
                    .padding()
                
                Text("Name: \(userProfile.name)")
                    .font(.headline)
                
                Text("Balance: \(userProfile.currency) \(userProfile.balance, specifier: "%.2f")")
                    .font(.largeTitle)
                    .padding()
                
                TextField("Enter amount", text: $balanceInput)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                
                HStack {
                    Button(action: {
                        addBalance(to: userProfile)
                    }) {
                        Text("Add")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        subtractBalance(from: userProfile)
                    }) {
                        Text("Subtract")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding()
            } else {
                Text("No profile found.")
                    .font(.headline)
                    .padding()
            }
        }
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Transaction Result"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    private func addBalance(to profile: UserProfile) {
        if let amount = Double(balanceInput), amount > 0 {
            profile.balance += amount
            try? modelContext.save()
            alertMessage = "Successfully added \(profile.currency) \(amount) to your balance."
        } else {
            alertMessage = "Invalid amount. Please enter a valid number."
        }
        showAlert = true
    }
    
    private func subtractBalance(from profile: UserProfile) {
        if let amount = Double(balanceInput), amount > 0, profile.balance >= amount {
            profile.balance -= amount
            try? modelContext.save()
            alertMessage = "Successfully subtracted \(profile.currency) \(amount) from your balance."
        } else {
            alertMessage = "Invalid amount or insufficient funds."
        }
        showAlert = true
    }
}

#Preview {
    BalanceView()
}
