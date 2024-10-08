//
//  Model.swift
//  expenseTracker
//
//  Created by Artiom Gramatin on 07.10.2024.
//

import Foundation
import SwiftData

@Model
class UserProfile {
    var id: Int
    var name: String
    var balance: Double
    var currency: String = "USD"
    
    init(id: Int = 1, name: String = "", balance: Double = 0, currency: String = "USD") {
        self.id = id
        self.name = name
        self.balance = balance
        self.currency = currency
    }
}
