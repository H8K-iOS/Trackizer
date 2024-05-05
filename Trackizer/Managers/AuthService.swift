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
            
            self.dataBase.collection("users")
                .document(resultUser.uid)
                .setData([
                    "username": username,
                    "email": email,
                    "password": password
                ]) { error in
                    if let error = error {
                        completion(false, error)
                        return
                    }
                    
                    completion(true, nil)
                }
        }
    }
    
    public func signin(with userRequest: LoginUserRequest,
                       completion: @escaping(Error?) -> Void) {
        Auth.auth().signIn(withEmail: userRequest.email, password: userRequest.password) {
            result, error in
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
}

