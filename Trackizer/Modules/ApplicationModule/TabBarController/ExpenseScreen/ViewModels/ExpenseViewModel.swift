import FirebaseFirestore
import FirebaseAuth

final class ExpenseViewModel {
    //MARK: - Constants
    let db = Firestore.firestore()
    private let authService = AuthService.shared
    
    //MARK: - Variables
    var onExpenseUpdate: (()-> Void)?
    var filtered: [ExpenseModel] = []
    var expense: [ExpenseModel] = [] {
        didSet {
            self.onExpenseUpdate?()
        }
    }
    
    init() {}
    
    //MARK: - Methods
    public func numberOfRows(isSearchActive: Bool) -> Int {
         return isSearchActive ? filtered.count : expense.count
     }
    
    public func isSearchActive(searchText: String?) -> Bool {
           
            return searchText?.isEmpty == false
        }
        
    public func updateSearchController(searchText: String?) {
          if let searchText = searchText, !searchText.isEmpty {
              self.filtered = self.expense.filter({$0.categoryName.lowercased().contains(searchText.lowercased())})
              
          } else {
              self.filtered = []
          }
          self.onExpenseUpdate?()
      }

    //MARK: Fetch Methods
    func fetchExpense(completion: @escaping(([ExpenseModel]?, Error?)->Void)) {
        authService.fetchExpense(completion: completion)
    }
    
    
    //TODO: -
    //MARK: - Delete Methods
    func deleteExpense(expenseID: String, completion: @escaping (Error?) -> Void) {
        guard let userUID = Auth.auth().currentUser?.uid else {
            completion(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User not logged in"]))
            return
        }

        let expenseDocRef = db.collection("users").document(userUID).collection("Spends").document(expenseID)

       
        expenseDocRef.getDocument { document, error in
            if let error = error {
                completion(error)
                return
            }

            guard let document = document, document.exists, let data = document.data() else {
                completion(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Expense not found"]))
                return
            }

       
            let categoryName = data["categoryName"] as? String ?? ""
            let moneySpent = data["moneySpent"] as? Double ?? 0.0

            let categoryDocRef = self.db.collection("users").document(userUID).collection("Category").document(categoryName)

        
            categoryDocRef.getDocument { categoryDoc, error in
                if let error = error {
                    completion(error)
                    return
                }

                guard let categoryDoc = categoryDoc, categoryDoc.exists, let categoryData = categoryDoc.data() else {
                    completion(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Category not found"]))
                    return
                }

                let currentMoneySpent = categoryData["moneySpent"] as? Double ?? 0.0
                let updatedMoneySpent = currentMoneySpent - moneySpent

                categoryDocRef.updateData(["moneySpent": updatedMoneySpent]) { error in
                    if let error = error {
                        completion(error)
                        return
                    }

                    
                    expenseDocRef.delete { error in
                        if let error = error {
                            completion(error)
                        } else {
                            completion(nil)
                        }
                    }
                }
            }
        }
    }

}
