import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ChoreViewModel()
    @State private var showingAddChore = false
    @State private var selectedChore: Chore?
    @State private var isEditMode: EditMode = .inactive
    
    var body: some View {
        Group {
            if UIDevice.current.userInterfaceIdiom == .pad {
                iPadLayout
            } else {
                iPhoneLayout
            }
        }
        .environment(\.editMode, $isEditMode)
    }
    
//    var body: some View {
//        Group {
//            if UIDevice.isIPad {
//                iPadLayout
//            } else {
//                iPhoneLayout
//            }
//        }
//        .environment(\.editMode, $isEditMode)
//    }

    private var iPadLayout: some View {
        NavigationStack {
            VStack {
                header
                choreList
                transactionList
            }
            .navigationTitle("Chores")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddChore = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddChore) {
                AddChoreView(viewModel: viewModel)
            }
            .sheet(item: $selectedChore) { chore in
                EditChoreView(viewModel: viewModel, chore: chore)
            }
        }
    }

//    private var iPadLayout: some View {
//        VStack {
//            header
//            choreList
//        }
//        .navigationTitle("Chores")
//        .navigationBarItems(leading: EditButton(), trailing: Button(action: {
//            showingAddChore = true
//        }) {
//            Image(systemName: "plus")
//        })
//        .sheet(isPresented: $showingAddChore) {
//            AddChoreView(viewModel: viewModel)
//        }
//        .sheet(item: $selectedChore) { chore in
//            EditChoreView(viewModel: viewModel, chore: chore)
//        }
//    }
    
    private var iPhoneLayout: some View {
        NavigationStack {
            VStack {
                header
                choreList
                transactionList
            }
            .navigationTitle("Chores")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddChore = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddChore) {
                AddChoreView(viewModel: viewModel)
            }
            .sheet(item: $selectedChore) { chore in
                EditChoreView(viewModel: viewModel, chore: chore)
            }
        }
    }

//    private var iPhoneLayout: some View {
//        NavigationStack {
//            VStack {
//                header
//                choreList
//            }
//            .navigationTitle("Chores")
//            .navigationBarItems(leading: EditButton(), trailing: Button(action: {
//                showingAddChore = true
//            }) {
//                Image(systemName: "plus")
//            })
//            .sheet(isPresented: $showingAddChore) {
//                AddChoreView(viewModel: viewModel)
//            }
//            .sheet(item: $selectedChore) { chore in
//                EditChoreView(viewModel: viewModel, chore: chore)
//            }
//        }
//    }
    
    private var header: some View {
        HStack {
            Text("Balance:")
                .font(.headline)
            Spacer()
            Text("$\(viewModel.balance, specifier: "%.2f")")
                .font(.headline)
        }
        .padding()
    }
    
    private var choreList: some View {
        List {
            ForEach(viewModel.chores) { chore in
                HStack {
                    Button(action: {
                        if chore.isCompleted {
                            viewModel.markChoreIncomplete(chore)
                        } else {
                            viewModel.markChoreCompleted(chore)
                        }
                    }) {
                        Image(systemName: chore.isCompleted ? "checkmark.circle.fill" : "circle")
                            .foregroundColor(chore.isCompleted ? .green : .primary)
                    }
                    .buttonStyle(PlainButtonStyle())

                    VStack(alignment: .leading) {
                        Text(chore.name)
                            .font(.headline)
                        Text("$\(chore.value, specifier: "%.2f")")
                            .font(.subheadline)
                    }

                    Spacer()

                    if isEditMode == .active {
                        Button(action: {
                            selectedChore = chore
                        }) {
                            Image(systemName: "pencil")
                        }
                    }
                }
            }
            .onDelete { indexSet in
                if isEditMode == .active {
                    viewModel.chores.remove(atOffsets: indexSet)
                }
            }
        }
    }

//    private var choreList: some View {
//        List {
//            ForEach(viewModel.chores) { chore in
//                HStack {
//                    VStack(alignment: .leading) {
//                        Text(chore.name)
//                            .font(.headline)
//                        Text("$\(chore.value, specifier: "%.2f")")
//                            .font(.subheadline)
//                    }
//                    Spacer()
//                    if chore.isCompleted {
//                        Text("Completed")
//                            .foregroundColor(.green)
//                    } else {
//                        Button(action: {
//                            viewModel.markChoreCompleted(chore)
//                        }) {
//                            Text("Mark as Completed")
//                        }
//                    }
//                }
//                .contentShape(Rectangle())
//                .onTapGesture {
//                    if isEditMode == .active {
//                        selectedChore = chore
//                    }
//                }
//            }
//            .onDelete { indexSet in
//                if isEditMode == .active {
//                    viewModel.chores.remove(atOffsets: indexSet)
//                }
//            }
//        }
//    }
    
    private var transactionList: some View {
        List {
            ForEach(viewModel.transactions) { transaction in
                HStack {
                    VStack(alignment: .leading) {
                        Text(transaction.description)
                            .font(.headline)
                        Text(transaction.date, style: .date)
                            .font(.subheadline)
                    }
                    Spacer()
                    Text("$\(transaction.amount, specifier: "%.2f")")
                        .font(.headline)
                }
            }
        }
    }

}

