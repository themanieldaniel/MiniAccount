//
//  AddTransactionView.swift
//  MiniAccount
//
//  Created by Daniel on 7/24/24.
//


import SwiftUI

struct AddTransactionView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: TransactionViewModel
    
    @State private var amount: String = ""
    @State private var description: String = ""
    @State private var category: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Description", text: $description)
                TextField("Category", text: $category)
                TextField("Amount", text: $amount)
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add Transaction")
            .navigationBarItems(leading: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            }, trailing: Button("Save") {
                if let amount = Double(amount) {
                    let transaction = Transaction(description: description, amount: amount, date: Date())
                    viewModel.addTransaction(transaction)
                    presentationMode.wrappedValue.dismiss()
                }
            })
        }
    }
}
