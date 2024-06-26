import FirebaseAuth
import FirebaseFirestore
final class AddNewCategoryViewModel {
    //MARK: Constants
    private let authService = AuthService.shared
    let categories = ["Security", "Auto", "Entertainment", "Medecine", "Restaurants", "Grocceries", "Taxi", "Flowers", "Personal", "Fashion"]
   
    //MARK: Lifecycle
    init() {
    }
    
    //MARK: - Computed Properties
    func addCategory(categoryName: String, categoryBudget: Double, completion: @escaping(Error?)->Void) {
        authService.addNewCategory(categoryName: categoryName, totalBudget: categoryBudget, completion: completion)
    }
}
