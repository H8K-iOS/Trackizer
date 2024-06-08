import Foundation
import UIKit
import FirebaseAuth

final class SignViewModel {
    
    init() {}
    
    func signup(username: String, email: String, password: String, vc: UIViewController, completion: @escaping (Error?) -> Void) {
        let registerUserRequest = RegisterUserRequest(userName: username.lowercased(),
                                                      email: email.lowercased(),
                                                      password: password)
        
        // Validate inputs
        if !ValidationManager.isValidUsername(for: registerUserRequest.userName) {
            AlertManager.showInvalidUsernameAlert(on: vc)
            return
        }
        
        if !ValidationManager.isValidEmail(for: registerUserRequest.email) {
            AlertManager.showInvalidEmailAlert(on: vc)
            return
        }
        
        if !ValidationManager.isValidPassword(for: registerUserRequest.password) {
            AlertManager.showInvalidPasswordAlert(on: vc)
            return
        }

        AuthService.shared.registerUsers(with: registerUserRequest) { wasRegistered, error in
            if let error = error {
                AlertManager.showRegistrationErrorAlert(on: vc, with: error)
            } else if wasRegistered {
                completion(nil)
            } else {
                let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Registration failed"])
                completion(error)
            }
        }
    }
    
    
    func signIn(email: String, password: String, vc: UIViewController, completion: @escaping(Error?)-> Void) {
        let loginUserRequest = LoginUserRequest(email: email.lowercased(), password: password)
        
        if !ValidationManager.isValidEmail(for: loginUserRequest.email) {
            AlertManager.showInvalidEmailAlert(on: vc)
            return
        }
        
        if !ValidationManager.isValidPassword(for: loginUserRequest.password) {
            AlertManager.showInvalidPasswordAlert(on: vc)
            return
        }
        
        print(loginUserRequest)
        
        AuthService.shared.signin(with: loginUserRequest) { error in
            if let error = error {
                AlertManager.showSigninErrorAlert(on: vc, with: error)
                completion(error)
                return
            }
            
            if let sceneDelegate = vc.view.window?.windowScene?.delegate as? SceneDelegate {
                sceneDelegate.checkAunthentification()
                completion(nil)
            }
        }
    }
}
