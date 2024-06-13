import Foundation
import FirebaseFirestore
import FirebaseAuth



final class BudgetViewModel {
    
    //MARK: - Constants
    private let authService = AuthService.shared
    
    //MARK: - Variables
    var onBudgetUpdate: (()->Void)?
    var categories: [BudgetModel] = [] {
        didSet {
            self.onBudgetUpdate?()
        }
    }
   

    init(){
        
        
    }
    
    //MARK: - Methods
    func numberOfRows() -> Int{
        categories.count
    }
    
    func fetchCategories(completion: @escaping ([BudgetModel]?, Error?) -> Void) {
        authService.fetchCategories(completion: completion)
    }
    
    
    
    func fetchCategorySpending(completion: @escaping([String: Double]?, Error?) -> Void) {
        authService.fetchCategorySpending(completion: completion)
    }
    

    
    func leftToSpend(total: Double?, currentValue: Double?) -> Double? {
        guard let totalBudgetForCategory = total,
              let currentCategoryValue = currentValue else { return 0}
        
        return totalBudgetForCategory - currentCategoryValue
        
    }
    
    func calculateTotalSpending() -> Double {
        authService.calculateTotalSpending()
        
    }
    
    func calculateTotalBudget() -> Double {
        authService.calculateTotalBudget()
    }
}



