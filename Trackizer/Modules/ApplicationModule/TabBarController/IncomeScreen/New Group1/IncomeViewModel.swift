import FirebaseFirestore
import FirebaseAuth

final class IncomeViewModel {
    //MARK: - Constants
    let incomeCategories = ["Work", "Saving","Others"]
    private let authService = AuthService.shared
    private let db = Firestore.firestore()
    
    //MARK: - Variable
    var onIncomeUpdate: (()-> Void)?
    var income: [IncomeModel] = [] {
        didSet {
            self.onIncomeUpdate?()
        }
    }
    
    //MARK: - Lifecycle
    init() {}
    
    //MARK: - Methods
    func numberOfRows() -> Int{
        income.count
    }
    
    func fetchIncome(completion: @escaping(([IncomeModel]?, Error?)->Void)) {
        authService.fetchIncome(completion: completion)
    }
    
    func addNewIncome(incomeSource: String, date: Date, amount: Double, completion: @escaping(Error?)->Void) {
        authService.addNewIncome(incomeSourceName: incomeSource, date: date, amount: amount, completion: completion)
    }
    
    //TODO: -
    func deleteIncome(incomeID: String, completion: @escaping (Error?) -> Void) {
        guard let userUID = Auth.auth().currentUser?.uid else {
            completion(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User not logged in"]))
            return
        }

        let incomeDocRef = self.db.collection("users").document(userUID).collection("Incomes").document(incomeID)
        
        incomeDocRef.delete { error in
            if let error = error {
                completion(error)
            } else {
                completion(nil)
            }
        }
    }
}
