import Foundation
import UIKit
import FirebaseAuth

final class SignViewModel {
    
    init() {}
    
    func signup(username: String, email: String, password: String, vc: UIViewController) {
        let registerUserRequest = RegisterUserRequest(userName: username.lowercased(),
                                                      email: email.lowercased(),
                                                      password: password)
        
        // username check
        if !ValidationManager.isValidUsername(for: registerUserRequest.userName) {
            AlertManager.showInvalidUsernameAlert(on: vc)
            return
        }
        
        // email check
        if !ValidationManager.isValidEmail(for: registerUserRequest.email) {
            AlertManager.showInvalidEmailAlert(on: vc)
            return
        }
        
        // password check
        if !ValidationManager.isValidPassword(for: registerUserRequest.password) {
            AlertManager.showInvalidPasswordAlert(on: vc)
            return
        }
        
        print(registerUserRequest)
        
        AuthService.shared.registerUsers(with: registerUserRequest) { [weak self] (wasRegistered: Bool, error: Error?) in
            guard let self = self else { return }
            
            if let error = error {
                print("Registration error: \(error.localizedDescription)")
                AlertManager.showRegistrationErrorAlert(on: vc, with: error)
                return
            }
            
            if wasRegistered {
                print("User registered successfully in AuthService")
                // Now authenticate with Firebase
                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    if let error = error {
                        print("Firebase authentication error: \(error.localizedDescription)")
                        AlertManager.showRegistrationErrorAlert(on: vc, with: error)
                        return
                    }
                    
                    print("Firebase user created successfully")
                    // After successful Firebase authentication, navigate to BudgetViewController
                    if let sceneDelegate = vc.view.window?.windowScene?.delegate as? SceneDelegate {
                        print("Calling sceneDelegate.checkAunthentification()")
                        sceneDelegate.checkAunthentification()
                    }
                }
            } else {
                print("User was not registered in AuthService")
                AlertManager.showRegistrationErrorAlert(on: vc)
            }
        }
    }
    
    func signIn(email: String, password: String, vc: UIViewController) {
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
                return
            }
            
            if let sceneDelegate = vc.view.window?.windowScene?.delegate as? SceneDelegate {
                sceneDelegate.checkAunthentification()
            }
        }
    }
}
