import Foundation
import FirebaseAuth
import FirebaseFirestore


final class AuthService {
    public static let shared = AuthService()
    private let db = Firestore.firestore()
    private var categoriesSource: [String: Double] = [:]
    private var categoryBudgetSource: [String: Double] = [:]
    
    
    private init() {}
    
    //MARK: - Authorization Methods
    
    /// A method to register the user
    /// - Parameters:
    ///   - userRequest: The users information(email, password)
    ///   - completion: A completion w 2 values...
    ///   - Bool: wasRegistered - Determins if ther user was registered and saved in the database correctly
    ///   - Error?: An optional Error if Firebase provides ones
    public func registerUsers(with userRequest: RegisterUserRequest,
                              completion: @escaping(Bool, Error?) -> Void) {
        
        let username = userRequest.userName
        let email = userRequest.email
        let password = userRequest.password
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(false, error)
                return
            }
            
            guard let resultUser = result?.user else {
                completion(false, nil)
                return
            }
            
            let userData: [String: Any] = [
                "username": username,
                "email": email,
                "password": password
            ]
            
            let userCollectionRef = self.db.collection("users")
            
            userCollectionRef.document(resultUser.uid).setData(userData) { error in
                if let error = error {
                    completion(false, error)
                    return
                } else {
                    completion(true, nil)
                }
            }
        }
    }
    
    public func signin(with userRequest: LoginUserRequest,
                       completion: @escaping(Error?) -> Void) {
        Auth.auth().signIn(withEmail: userRequest.email, password: userRequest.password) { result, error in
            if let error = error {
                completion(error)
                return
            } else {
                completion(nil)
            }
        }
    }
    
    public func signOut(completion: @escaping(Error?) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(nil)
        } catch let error{
            completion(error)
        }
    }
    
    public func forgotPassword(with email: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            completion(error)
        }
    }
    
    
    
    
    //MARK: - Category Add Methods
    func addNewCategory(categoryName: String, totalBudget: Double, completion: @escaping (Error?) -> Void) {
            guard let userUID = Auth.auth().currentUser?.uid else {
                completion(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User not logged in"]))
                return
            }
            
            let categoryRef = db.collection("users").document(userUID).collection("Category").document(categoryName)
            
            categoryRef.getDocument { document, error in
                if let document = document, document.exists {
                    if let error {
                        completion(error)
                    }
                } else {
                    categoryRef.setData([
                        "categoryName": categoryName,
                        "moneySpent": 0.0,
                        "total": totalBudget
                    ]) { error in
                        completion(error)
                    }
                }
            }
    }
    
    func updateCategorySpending(categoryName: String, amount: Double, completion: @escaping (Error?) -> Void) {
        guard let userUID = Auth.auth().currentUser?.uid else {
            completion(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User not logged in"]))
            return
        }
        
        let categoryRef = db.collection("users").document(userUID).collection("Category").document(categoryName)
        
        categoryRef.getDocument { document, error in
            if let document = document, document.exists {
                categoryRef.updateData([
                    "moneySpent": FieldValue.increment(amount)
                ]) { error in
                    completion(error)
                }
            } else {
                categoryRef.setData([
                    "categoryName": categoryName,
                    "moneySpent": amount,
                    "total": 0.0
                ]) { error in
                    completion(error)
                }
            }
        }
    }
    
    func editCategoryBudget(categoryName:  String, budget: Double, completion: @escaping(Error?)-> Void) {
        guard let userUID = Auth.auth().currentUser?.uid else {
            completion(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User not logged in"]))
            return
        }
        let  categoryRef = db.collection("users").document(userUID).collection("Category").document(categoryName)
        
        categoryRef.getDocument { document, error in
            if let document = document, document.exists {
                categoryRef.updateData([
                    "total": budget
                ]) { error in
                    completion(error)
                }
            
            }
        }
    }
    
    //MARK: - Category Fetch Methods
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
    
    //MARK: Category Calculate Methods
    func calculateTotalSpending() -> Double {
        return self.categoriesSource.values.reduce(0, +)
        
    }
    
    func calculateTotalBudget() -> Double {
        return self.categoryBudgetSource.values.reduce(0, +)
    }
    
    //MARK: - Spends Add Methods
    func addNewSpends(categoryName: String, spendsName: String, date: Date, amount: Double, completion: @escaping (Error?) -> Void) {
        guard let userUID = Auth.auth().currentUser?.uid else {
            completion(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User not logged in"]))
            return
        }

        let spendsCollectionRef = db.collection("users").document(userUID).collection("Spends")
        
        
        let newDocumentRef = spendsCollectionRef.document()
        let expenseID = newDocumentRef.documentID

        newDocumentRef.setData([
            "expenseID": expenseID,
            "categoryName": categoryName,
            "spendsName": spendsName,
            "date": date,
            "moneySpent": amount
        ]) { error in
            completion(error)
        }
    }
    
    //MARK: - Spends Fetch Methods
    func fetchExpense(completion: @escaping(([ExpenseModel]?, Error?)->Void)) {
        guard let userUID = Auth.auth().currentUser?.uid else {
            completion(nil, NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User not logged in"]))
            return
        }
        
        let spendsCollectionRef = db.collection("users").document(userUID).collection("Spends")
        
        spendsCollectionRef.getDocuments { snapshot, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let documents = snapshot?.documents else {
                completion(nil, NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No documents found"]))
                return
            }
            
            let spends = documents.compactMap { document -> ExpenseModel? in
                return ExpenseModel(document: document)
            }
            
            completion(spends, nil)
        }
    }
    
    //MARK: Spends Calculate Methods
    func calculateExpense(completion: @escaping(Int,Double,Int)->Void) {
        self.fetchExpense { expense, error in
            guard let expense = expense else {
                completion(0, 0.0, 0)
                return
            }
            
            let totalExpends = expense.reduce(0) {$0 + $1.amount}
            let count = expense.count
            
            
            var categoryTotals: [String: Double] = [:]
            
            for expense in expense {
                
                if let currentTotal = categoryTotals[expense.categoryName] {
                    categoryTotals[expense.categoryName] = currentTotal + expense.amount
                } else {
                    
                    categoryTotals[expense.categoryName] = expense.amount
                }
            }
            let categoryCount = categoryTotals.count
            
            completion(count, totalExpends, categoryCount)
        }
    }
    
    //MARK: - Incomes Add Methods
    func addNewIncome(incomeSourceName: String, date: Date, amount: Double, completion: @escaping (Error?)->Void) {
        guard let userUID = Auth.auth().currentUser?.uid else {
            completion(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User not logged in"]))
            return
        }

        let categoryRef = db.collection("users").document(userUID).collection("Incomes")
        
        let newDocumentRef = categoryRef.document()
        let incomeID = newDocumentRef.documentID
        
        newDocumentRef.setData([
            "incomeID": incomeID,
            "amount": amount,
            "date": date,
            "incomeSource": incomeSourceName
        ]) { error in
            completion(error)
        }
        
    }
    
    
    //MARK: - Incomes Fetch Methods
    func fetchIncome(completion: @escaping(([IncomeModel]?, Error?)->Void)) {
        guard let userUID = Auth.auth().currentUser?.uid else {
            completion(nil, NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User not logged in"]))
            return
        }
        let db = Firestore.firestore()
        
        db.collection("users").document(userUID).collection("Incomes").getDocuments { snapshot, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let documents = snapshot?.documents else {
                completion(nil, NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No categories found"]))
                return
            }
            
            let income = documents.compactMap { IncomeModel(document: $0) }
            completion(income, nil)
        }
    }

    //MARK: - Incomes Calculate Methods
    func calculateIncome(completion: @escaping (Int,Double,Int) -> Void) {
        fetchIncome { income, error in
            guard let income = income else {
                completion(0, 0.0, 0)
                return
            }
            let totalIncome = income.reduce(0) {$0 + $1.amount}
            let count = income.count
            
            
            var categoiesTotal: [String: Double] = [:]

            // Aggregate the expense amounts by category
            for income in income {
                if let currentTotal = categoiesTotal[income.incomeSource] {
                    categoiesTotal[income.incomeSource] = currentTotal + income.amount
                } else {
                    categoiesTotal[income.incomeSource] = income.amount
                }
            }
            
            let categoriesCount = categoiesTotal.count
            
            completion(count, totalIncome, categoriesCount)
        }
        
        
        
    }
}
