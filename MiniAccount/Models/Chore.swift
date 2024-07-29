//
//  Chore.swift
//  MiniAccount
//
//  Created by Daniel on 7/25/24.
//


import Foundation

struct Chore: Identifiable, Codable {
    let id: UUID
    var name: String
    var value: Double
    var isCompleted: Bool
    var lastCompletedDate: Date?

    init(name: String, value: Double, isCompleted: Bool = false) {
        self.id = UUID()
        self.name = name
        self.value = value
        self.isCompleted = isCompleted
    }
}
