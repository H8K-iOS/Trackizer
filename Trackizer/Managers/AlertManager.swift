import UIKit

final class AlertManager {
    //MARK: Constants
    
    
    //MARK: Variables
    
  
    //MARK: Methods
    
    private static func showAlert(on vc: UIViewController, title: String, message: String?) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            
            vc.present(alert, animated: true)
        }
    }
    
}

//MARK: - Extensions
    //MARK: - Show Validation Alertrs
extension AlertManager {
    public static func showInvalidUsernameAlert(on vc: UIViewController) {
        self.showAlert(on: vc, title: "Invalid Username", message: "Please enter a valid Username.")
    }
    
    public static func showInvalidEmailAlert(on vc: UIViewController) {
        self.showAlert(on: vc, title: "Invalid E-mail", message: "Please enter a valid E-mail.")
    }
    
    public static func showInvalidPasswordAlert(on vc: UIViewController) {
        self.showAlert(on: vc, title: "Invalid Password", message: "Please enter a valid password.")
    }
}


//MARK: - Registrations Errors
extension AlertManager {
   
   public static func showRegistrationErrorAlert(on vc: UIViewController) {
       self.showAlert(on: vc, title: "Unknown Registration Error", message: nil)
   }
   
   public static func showRegistrationErrorAlert(on vc: UIViewController, with error: Error) {
       self.showAlert(on: vc, title: "Invalid E-mail.", message: "\(error.localizedDescription)")
   }
}

//MARK: - Login Errors
extension AlertManager {
   
   public static func showSigninErrorAlert(on vc: UIViewController) {
       self.showAlert(on: vc, title: "Unknown Error Signing In", message: nil)
   }
   
    public static func showSigninErrorAlert(on vc: UIViewController, with error: Error) {
        self.showAlert(on: vc, title: "Error Signing In", message: "\(error.localizedDescription)")
    }
}

//MARK: - Logout Errors
extension AlertManager {
    public static func showLogoutErrorAlert(on vc: UIViewController, with error: Error) {
        self.showAlert(on: vc, title: "Unknown Log Out Error", message: "\(error.localizedDescription)")
    }
}

//MARK: - Forgot Password
extension AlertManager {
    public static func showPasswordResetSent(on vc: UIViewController) {
        self.showAlert(on: vc, title: "Password Reset Message Sent", message: nil)
    }
    
    public static func showErrorSendingPasswordReset(on vc: UIViewController, with error: Error) {
        self.showAlert(on: vc, title: "Error Sending Password Reset", message: "\(error.localizedDescription)")
    }
}

//MARK: - Fetching Users Errors
extension AlertManager {
    public static func ShowFetchingUserError(on vc: UIViewController, with error: Error) {
        self.showAlert(on: vc, title: "Error Fetching User", message: "\(error.localizedDescription)")
    }
    
    public static func ShowUnknownFetchingUserError(on vc: UIViewController, with error: Error) {
        self.showAlert(on: vc, title: "Unknown Error Fetching User", message: "\(error.localizedDescription)")
    }
}

//MARK: - Category Errors
extension AlertManager {
   
   public static func showAddCategoryErrorAlert(on vc: UIViewController) {
       self.showAlert(on: vc, title: "Invalid Category Name/Category Amount or Category Already exists.", message: nil)
   }
   
   public static func showAddCategoryErrorAlert(on vc: UIViewController, with error: Error) {
       self.showAlert(on: vc, title: "Invalid Category Name/Category Amount or Category Already exists.", message: "\(error.localizedDescription)")
   }
}

//MARK: - Add spends Errors
extension AlertManager {
   
   public static func showAddSpendsErrorAlert(on vc: UIViewController) {
       self.showAlert(on: vc, title: "Invalid Spends Name/Spends Amount.", message: nil)
   }
   
   public static func showAddSpendsErrorAlert(on vc: UIViewController, with error: Error) {
       self.showAlert(on: vc, title: "Invalid Spends Name/Spends Amount.", message: "\(error.localizedDescription)")
   }
}


