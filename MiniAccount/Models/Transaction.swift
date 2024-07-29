//
//  Transaction.swift
//  MiniAccount
//
//  Created by Daniel on 7/24/24.
//

import Foundation

struct Transaction: Identifiable, Codable {
    let id: UUID
    let description: String
    let amount: Double
    let date: Date

    init(description: String, amount: Double, date: Date = Date()) {
        self.id = UUID()
        self.description = description
        self.amount = amount
        self.date = date
    }
}
