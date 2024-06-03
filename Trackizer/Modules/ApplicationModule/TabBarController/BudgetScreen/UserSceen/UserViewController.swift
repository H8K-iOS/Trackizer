//import UIKit
//
//final class UserViewController: UIViewController {
//    //MARK: Constants
//    
//    var username: String = ""
//    let email: String = ""
//    //MARK: Variables
//    
//    
//    //MARK: Lifecycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        self.view.backgroundColor = .red
//        
//        fetch()
//    }
//    //MARK: Methods
//    
//    func fetch() {
//        FirestoreManager.shared.fetchUser { [weak self] user, error in
//            guard let self = self else { return }
//            if let error = error {
//                AlertManager.ShowFetchingUserError(on: self, with: error)
//            }
//            
//            if let user = user {
//                self.username = user.username
//                print(self.username)
//            }
//        }
//    }
//}
//
////MARK: - Extensions
//private extension UserViewController {
//    
//}
