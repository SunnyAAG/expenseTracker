//
//  ContentView.swift
//  expenseTracker
//
//  Created by Artiom Gramatin on 07.10.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State var isActive: Bool = false
    
    var body: some View {
        
        ZStack{
            if isActive {
                MainView()
            }else{
                ZStack {
                    Color(.blue)
                        .ignoresSafeArea()
                    VStack {
                        Image(systemName: "globe")
                            .imageScale(.large)
                            .foregroundStyle(.white)
                        Text("Hello, world!")
                            .foregroundStyle(.white)
                    }
                    .padding()
                }
            }
        }
        .onAppear {DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {withAnimation {self.isActive = true}}}
    }
}

#Preview {
    ContentView()
}
