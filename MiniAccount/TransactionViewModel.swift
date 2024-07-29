//
//  TransactionViewModel.swift
//  MiniAccount
//
//  Created by Daniel on 7/24/24.
//

import Foundation
import Combine

class TransactionViewModel: ObservableObject {
    @Published var transactions: [Transaction] = []
    
    var balance: Double {
        transactions.reduce(0) { $0 + $1.amount }
    }
    
    init() {
        loadTransactions()
    }
    
    func addTransaction(_ transaction: Transaction) {
        transactions.append(transaction)
        saveTransactions()
    }
    
    func removeTransaction(at offsets: IndexSet) {
        transactions.remove(atOffsets: offsets)
        saveTransactions()
    }
    
    private func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    private func loadTransactions() {
        let url = getDocumentsDirectory().appendingPathComponent("transactions.json")
        if let data = try? Data(contentsOf: url) {
            if let decodedTransactions = try? JSONDecoder().decode([Transaction].self, from: data) {
                transactions = decodedTransactions
            }
        }
    }
    
    private func saveTransactions() {
        let url = getDocumentsDirectory().appendingPathComponent("transactions.json")
        if let data = try? JSONEncoder().encode(transactions) {
            try? data.write(to: url)
        }
    }
}
