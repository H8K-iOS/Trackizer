import FirebaseFirestore
import FirebaseAuth

final class IncomeViewModel {
    var onIncomeUpdate: (()-> Void)?
    var income: [IncomeModel] = [] {
        didSet {
            self.onIncomeUpdate?()
        }
    }
    
    let incomeCategories = ["Work", "Saving","Others"]
    private let authService = AuthService.shared
    init() {}
    
    func numberOfRows() -> Int{
        income.count
    }
    
    //MARK: - Methods
        //Fetch
    
    func fetchIncome(completion: @escaping(([IncomeModel]?, Error?)->Void)) {
        guard let userUID = Auth.auth().currentUser?.uid else {
            completion(nil, NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User not logged in"]))
            return
        }
        let db = Firestore.firestore()
        
        db.collection("users").document(userUID).collection("Incomes").getDocuments { snapshot, error in
            if let error {
                completion(nil, error)
                return
            }
            
            guard let documents = snapshot?.documents else {
                completion(nil, NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No categories found"]))
                return
            }
            let income = documents.compactMap {IncomeModel(document: $0) }
            completion(income, nil)
        }
    }
    
    func addNewIncome(incomeSource: String, date: String, amount: Double, completion: @escaping(Error?)->Void) {
        authService.addNewIncome(incomeSourceName: incomeSource, date: date, amount: amount, completion: completion)
    }
}
