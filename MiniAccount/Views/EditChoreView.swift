import SwiftUI

struct EditChoreView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: ChoreViewModel
    @State var chore: Chore

    var body: some View {
        NavigationStack {
            Form {
                TextField("Chore Name", text: $chore.name)
                TextField("Chore Value", value: $chore.value, format: .number)
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Edit Chore")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        viewModel.updateChore(chore)
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}
