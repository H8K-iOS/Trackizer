import Foundation
import FirebaseAuth
import FirebaseFirestore


final class AuthService {
    public static let shared = AuthService()
    private let dataBase = Firestore.firestore()
    
    private init() {}
    
    
    
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
            
            let userCollectionRef = self.dataBase.collection("users")
            
            userCollectionRef.document(resultUser.uid).setData(userData) { error in
                if let error = error {
                    completion(false, error)
                    return
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
    
    
    
    
    
    func updateCategorySpending(categoryName: String, amount: Double, completion: @escaping (Error?) -> Void) {
        guard let userUID = Auth.auth().currentUser?.uid else {
            completion(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User not logged in"]))
            return
        }
        
        let db = Firestore.firestore()
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
    
    
    func addNewCategory(categoryName: String, totalBudget: Double, completion: @escaping (Error?) -> Void) {
            guard let userUID = Auth.auth().currentUser?.uid else {
                completion(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User not logged in"]))
                return
            }
            
            let db = Firestore.firestore()
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


    func addNewSpends(categoryName: String, spendsName: String, amount: Double, completion: @escaping (Error?) -> Void) {
        guard let userUID = Auth.auth().currentUser?.uid else {
            completion(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User not logged in"]))
            return
        }
        
        let db = Firestore.firestore()
        let categoryRef = db.collection("users").document(userUID).collection("Spends").document(spendsName)
        
        categoryRef.getDocument { document, error in
            if let document = document, document.exists {
                if let error {
                    completion(error)
                }
            } else {
                categoryRef.setData([
                    "categoryName": categoryName,
                    "spendsName": spendsName,
                    "moneySpent": amount,
                ]) { error in
                    completion(error)
                }
            }
        }
    }
    
    func addNewIncome(incomeSourceName: String, date: String, amount: Double, completion: @escaping (Error?)->Void) {
        guard let userUID = Auth.auth().currentUser?.uid else {
            completion(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User not logged in"]))
            return
        }
        
        let db = Firestore.firestore()
        let categoryRef = db.collection("users").document(userUID).collection("Incomes").document(incomeSourceName)
        
        categoryRef.getDocument { snapshot, error in
            if let error {
                completion(error)
            } else{
                categoryRef.setData([
                "incomeSource": incomeSourceName,
                "date": date,
                "amount": amount
                ]) { error in
                    completion(error)
                }
            }
                
        }
        
    }
}
