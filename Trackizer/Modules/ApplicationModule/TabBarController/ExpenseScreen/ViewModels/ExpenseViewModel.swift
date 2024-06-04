import FirebaseFirestore
import FirebaseAuth

final class ExpenseViewModel {
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
        let db = Firestore.firestore()
        
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
}
