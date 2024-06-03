import Foundation
import FirebaseFirestore
import FirebaseAuth

final class BudgetViewModel {
    
    var onBudgetUpdate: (()->Void)?
    var categories: [BudgetModel] = [] {
        didSet {
            self.onBudgetUpdate?()
        }
    }
    
    private var categoriesSource: [String: Double] = [:]
    private var categoryBudgetSource: [String: Double] = [:]
    init(){
      
        
    }
    
    func numberOfRows() -> Int{
        categories.count
    }
    
    
    //MARK: - Fetch
    
    func fetchCategories(completion: @escaping ([BudgetModel]?, Error?) -> Void) {
        guard let userUID = Auth.auth().currentUser?.uid else {
            completion(nil, NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User not logged in"]))
            return
        }
        
        let db = Firestore.firestore()
        db.collection("users").document(userUID).collection("Category").getDocuments { (snapshot, error) in
            if let error = error {
                print("Error fetching categories: \(error)")
                completion(nil, error)
                return
            }
            
            guard let documents = snapshot?.documents else {
                completion(nil, NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No categories found"]))
                return
            }
            
            let categories = documents.compactMap { BudgetModel(document: $0) }
            completion(categories, nil)
        }
    }
    
    
    
func fetchCategorySpending(completion: @escaping([String: Double]?, Error?) -> Void) {
    guard let userUID = Auth.auth().currentUser?.uid else {
        completion(nil, NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User not logged in"]))
        return
    }
    
    let db = Firestore.firestore()
    db.collection("users").document(userUID).collection("Category").getDocuments { snapshot, error in
        if let error {
            print("Error fetching category spending: \(error)")
            completion(nil, error)
            return
        }
        
        var categorySpending = [String: Double]()
        var categoryBudget = [String: Double]()
        snapshot?.documents.forEach{ document in
            let categortyName = document["categoryName"] as? String ?? ""
            let moneySpent = document["moneySpent"] as? Double ?? 0.0
            let budget = document["total"] as? Double ?? 0.0
            categorySpending[categortyName] = moneySpent
            categoryBudget[categortyName] = budget
            self.categoriesSource = categorySpending
            self.categoryBudgetSource = categoryBudget
        }
        completion(categorySpending, nil)
        
    }
}
    
    
    
    func leftToSpend(total: Double?, currentValue: Double?) -> Double? {
        guard let totalBudgetForCategory = total,
              let currentCategoryValue = currentValue else { return 0}
        
        return totalBudgetForCategory - currentCategoryValue
        
    }
    
    func calculateTotalSpending() -> Double {
        return self.categoriesSource.values.reduce(0, +)
        
    }
    
    func calculateTotalBudget() -> Double {
        return self.categoryBudgetSource.values.reduce(0, +)
    }
}



