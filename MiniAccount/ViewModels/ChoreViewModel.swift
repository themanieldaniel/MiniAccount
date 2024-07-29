import Foundation

class ChoreViewModel: ObservableObject {
    @Published var chores: [Chore] {
        didSet {
            saveChores()
        }
    }
    @Published var transactions: [Transaction] {
        didSet {
            saveTransactions()
        }
    }
    @Published var balance: Double
//    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//    let choresURL: URL {
//        return documentsDirectory.appendingPathComponent("chores.json")
//    }
//    let transactionsURL: URL {
//        return documentsDirectory.appendingPathComponent("transactions.json")
//    }


    init() {
        self.chores = ChoreViewModel.loadChores()
        self.transactions = ChoreViewModel.loadTransactions()
        self.balance = 0
        balance = transactions.reduce(0) { $0 + $1.amount }
//        calculateBalance()
        resetChoresIfNeeded()
    }

    func addChore(_ chore: Chore) {
        chores.append(chore)
    }

    func updateChore(_ updatedChore: Chore) {
        if let index = chores.firstIndex(where: { $0.id == updatedChore.id }) {
            chores[index] = updatedChore
        }
    }

    func markChoreCompleted(_ chore: Chore) {
        if let index = chores.firstIndex(where: { $0.id == chore.id }) {
            chores[index].isCompleted = true
            let transaction = Transaction(description: chore.name, amount: chore.value)
            transactions.append(transaction)
            balance += chore.value
        }
    }

    func markChoreIncomplete(_ chore: Chore) {
        if let index = chores.firstIndex(where: { $0.id == chore.id }) {
            chores[index].isCompleted = false
            if let transactionIndex = transactions.firstIndex(where: { $0.description == chore.name && $0.amount == chore.value }) {
                balance -= transactions[transactionIndex].amount
                transactions.remove(at: transactionIndex)
            }
        }
    }

    func resetChores() {
        for index in chores.indices {
            chores[index].isCompleted = false
        }
    }

    func resetChoresIfNeeded() {
        let lastResetDate = UserDefaults.standard.object(forKey: "lastResetDate") as? Date ?? Date.distantPast
        if !Calendar.current.isDateInToday(lastResetDate) {
            resetChores()
            UserDefaults.standard.set(Date(), forKey: "lastResetDate")
        }
    }

    private static func loadChores() -> [Chore] {
        if let data = try? Data(contentsOf: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("chores.json")) {
            let decoder = JSONDecoder()
            return (try? decoder.decode([Chore].self, from: data)) ?? []
        }
        return []
    }

    private func saveChores() {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(chores) {
            try? data.write(to: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("chores.json"))
        }
    }

    private static func loadTransactions() -> [Transaction] {
        if let data = try? Data(contentsOf: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("transactions.json")) {
            let decoder = JSONDecoder()
            return (try? decoder.decode([Transaction].self, from: data)) ?? []
        }
        return []
    }

    private func saveTransactions() {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(transactions) {
            try? data.write(to: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("transactions.json"))
        }
    }

    private func calculateBalance() {
        balance = transactions.reduce(0) { $0 + $1.amount }
//        return transactions.reduce(0) { $0 + $1.amount }
    }
}
