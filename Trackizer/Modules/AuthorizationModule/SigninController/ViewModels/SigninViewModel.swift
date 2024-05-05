import Foundation
import UIKit

final class SigninViewModel {
    
    init() {}
    
    
    func signup(username: String, email: String, password: String, vc: UIViewController) {
        let registerUserRequest = RegisterUserRequest(userName: username.lowercased(),
                                                      email: email.lowercased(),
                                                      password: password)
        
        //username check
        if !ValidationManager.isValidUsername(for: registerUserRequest.userName) {
            AlertManager.showInvalidUsernameAlert(on: vc)
            return
        }
        
        //email check
        if !ValidationManager.isValidEmail(for: registerUserRequest.email) {
            AlertManager.showInvalidEmailAlert(on: vc)
            return
        }
        
        //password check
        if !ValidationManager.isValidPassword(for: registerUserRequest.password) {
            AlertManager.showInvalidPasswordAlert(on: vc)
            return
        }
        
        print(registerUserRequest)
        
        AuthService.shared.registerUsers(with: registerUserRequest) {(wasRegistered: Bool, error: Error?) in
            if let error = error {
                AlertManager.showRegistrationErrorAlert(on: vc, with: error)
                return
            }
            
            if wasRegistered {
                if let sceneDelegate = vc.view.window?.windowScene?.delegate as? SceneDelegate {
                    sceneDelegate.checkAunthentification()
                }
            } else {
                AlertManager.showRegistrationErrorAlert(on: vc)
            }

        }
    }
}
