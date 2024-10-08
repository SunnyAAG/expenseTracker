//
//  MainView.swift
//  expenseTracker
//
//  Created by Artiom Gramatin on 07.10.2024.
//

import SwiftUI
import SwiftData

struct MainView: View {
    
    var body: some View {
        NavigationStack {
            VStack{
                HStack{
                    Spacer()
                    Text("Profile")
                    NavigationLink{
                        ProfileView()
                    }label:{
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50)
                    }
                }
                .padding(.horizontal, 20)
                
                BalanceView()
                Spacer()
            }
        }
    }
}

#Preview {
    MainView()
}
