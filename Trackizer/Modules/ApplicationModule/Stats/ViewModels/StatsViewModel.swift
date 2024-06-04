final class StatsViewModel {
    
    var incomesSource: [IncomeModel] = [] {
        didSet {
            self.onUpdate?()
        }
    }
    
    var expenseSource: [ExpenseModel] = [] {
        didSet {
            self.onUpdate?()
        }
    }
    
    var onUpdate: (()->Void)?
    
    init() {}
    
}


