import FirebaseFirestore
import FirebaseAuth

final class ExpenseViewModel {
    let db = Firestore.firestore()
    var onExpenseUpdate: (()-> Void)?
    var expense: [ExpenseModel] = [] {
        didSet {
            self.onExpenseUpdate?()
        }
    }
    
    init() {}
    
    func numberOfRows() -> Int{
        expense.count
    }
    
    //MARK: - Methods
    //Fetch
    
    func fetchExpense(completion: @escaping(([ExpenseModel]?, Error?)->Void)) {
        guard let userUID = Auth.auth().currentUser?.uid else {
            completion(nil, NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User not logged in"]))
            return
        }
        
        db.collection("users").document(userUID).collection("Spends").getDocuments { snapshot, error in
            if let error {
                completion(nil, error)
                return
            }
            
            guard let documents = snapshot?.documents else {
                completion(nil, NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No categories found"]))
                return
            }
            let expense = documents.compactMap {ExpenseModel(document: $0) }
            completion(expense, nil)
        }
    }
    
    func deleteExpense(expenseName: String,completion: @escaping(Error?)-> Void) {
        guard let userUID = Auth.auth().currentUser?.uid else {
            completion(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User not logged in"]))
            return
        }
        
        let expenseDocRef = db.collection("users").document(userUID).collection("Spends").document(expenseName)
        
        expenseDocRef.getDocument { [self] document, error in
            if let document = document, document.exists {
                let data = document.data()
                let categoryName = data?["categoryName"] as? String ?? ""
                let moneySpent = data?["moneySpent"] as? Double ?? 0.0
                
                
                let categoryDocRef = db.collection("users").document(userUID).collection("Category").document(categoryName)
                
                categoryDocRef.getDocument { (categoryDoc, error) in
                    if let categoryDoc = categoryDoc, categoryDoc.exists {
                        let categoryData = categoryDoc.data()
                        let currentMoneySpent = categoryData?["moneySpent"] as? Double ?? 0.0
                        let updatedMoneySpent = currentMoneySpent - moneySpent
                        
                        
                        categoryDocRef.updateData(["moneySpent": updatedMoneySpent]) { error in
                            if let error = error {
                                completion(error)
                                return
                            }
                            
                            
                            expenseDocRef.delete { error in
                                completion(error)
                            }
                        }
                    } else {
                        completion(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Category not found"]))
                    }
                }
            } else {
                completion(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Expense not found"]))
            }
        }
    }
}
