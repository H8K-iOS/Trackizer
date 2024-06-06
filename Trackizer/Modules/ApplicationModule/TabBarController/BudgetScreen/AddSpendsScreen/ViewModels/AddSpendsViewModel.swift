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
    
    func updateCategoryBudget(categoryName:  String, budget: Double, completion: @escaping(Error?)-> Void) {
        authService.editCategoryBudget(categoryName:  categoryName, budget: budget, completion: completion)
    }
    
    func deleteCategory(categoryName: String, completion: @escaping (Error?) -> Void) {
        guard let userUID = Auth.auth().currentUser?.uid else {
            completion(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User not logged in"]))
            return
        }
        
        let db = Firestore.firestore()
        db.collection("users").document(userUID).collection("Category").document(categoryName).delete { error in
            completion(error)
        }
    }
}
