import Foundation
final class StatsViewModel {
    //MARK: - Variables
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
    
    var onUpdate: (() -> Void)?
    
    private var startDate: Date?
    private var endDate: Date?
    
    //MARK: - Methods
    
    func fetchIncome(completion: @escaping ([IncomeModel]?, Error?) -> Void) {
        // Предполагается, что authService.fetchIncome загружает все данные
        AuthService.shared.fetchIncome { [weak self] income, error in
            guard let self = self else { return }
            if let income = income {
                self.incomesSource = self.filterData(income, by: self.startDate, and: self.endDate)
            }
            completion(self.incomesSource, error)
        }
    }
    
    func fetchExpense(completion: @escaping ([ExpenseModel]?, Error?) -> Void) {
        // Предполагается, что authService.fetchExpense загружает все данные
        AuthService.shared.fetchExpense { [weak self] expense, error in
            guard let self = self else { return }
            if let expense = expense {
                self.expenseSource = self.filterData(expense, by: self.startDate, and: self.endDate)
            }
            completion(self.expenseSource, error)
        }
    }
    
    func setDateRange(startDate: Date, endDate: Date) {
        self.startDate = startDate
        self.endDate = endDate
        fetchIncome { _, _ in }
        fetchExpense { _, _ in }
    }
    
    private func filterData<T: HasDate>(_ data: [T], by startDate: Date?, and endDate: Date?) -> [T] {
        guard let startDate = startDate, let endDate = endDate else { return data }
        return data.filter { $0.date >= startDate && $0.date <= endDate }
    }
}

protocol HasDate {
    var date: Date { get }
}

extension IncomeModel: HasDate {}
extension ExpenseModel: HasDate {}
