import FirebaseAuth
import FirebaseFirestore
final class AddSpendsViewModel {
    //MARK: Constants
   
    let budget: BudgetModel
    let authService = AuthService.shared
    
    //MARK: Lifecycle
    init(_ budget: BudgetModel) {
        self.budget = budget
    }
    
    //MARK: - Computed Properties
    var categoryName: String {
        "\(budget.categoryName)"
    }
    
    func updateCategorySpending(categoryName: String, spendsName: String, amount: Double, completion: @escaping (Error?) -> Void) {
        authService.updateCategorySpending(categoryName: categoryName, amount: amount, completion: completion)
        
        authService.addNewSpends(categoryName: categoryName, spendsName: spendsName, amount: amount, completion: completion)
       }
}
