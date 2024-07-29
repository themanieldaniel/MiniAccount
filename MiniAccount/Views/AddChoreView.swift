import SwiftUI

struct AddChoreView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: ChoreViewModel
    @State private var name = ""
    @State private var value = ""

    var body: some View {
        NavigationStack {
            Form {
                TextField("Chore Name", text: $name)
                TextField("Chore Value", text: $value)
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add Chore")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        if let value = Double(value) {
                            let newChore = Chore(name: name, value: value)
                            viewModel.addChore(newChore)
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
            }
        }
    }
}
