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
        VStack(spacing: 30) {
            if let userProfile = userProfiles.first {
                
                Text("Balance")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                Text(userProfile.name)
                    .font(.headline)
                    .foregroundColor(.secondary)
                ZStack {
                    Circle()
                        .fill(Color.blue.opacity(0.1))
                        .frame(width: 300, height: 300)
                        .shadow(radius: 10)
                    
                    VStack {
                        Text("\(userProfile.currency)")
                            .font(.system(size: 30, weight: .bold))
                            .foregroundColor(.primary)
                        
                        Text("\(userProfile.balance, specifier: "%.2f")")
                            .font(.system(size: 40, weight: .bold))
                            .foregroundColor(.primary)
                    }
                }
                .padding(.bottom, 70)
                
                TextField("Enter amount", text: $balanceInput)
                    .keyboardType(.decimalPad)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(12)
                    .padding(.horizontal)
                HStack(spacing: 15) {
                    Button(action: {
                        addBalance(to: userProfile)
                    }) {
                        Text("Add")
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color.green.opacity(0.7))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    
                    Button(action: {
                        subtractBalance(from: userProfile)
                    }) {
                        Text("Subtract")
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color.red.opacity(0.7))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                }
                .padding(.horizontal)
            } else {
                Text("No profile found.")
                    .font(.headline)
                    .foregroundColor(.red)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(20)
        .shadow(radius: 5)
        .padding(.horizontal, 20)
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Transaction Result"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        .onTapGesture {
            hideKeyboard()
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
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    BalanceView()
}
