import UIKit
import FirebaseFirestore
import FirebaseAuth

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        self.setScene(with: scene)
        checkAunthentification()
    }

    private func setScene(with scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        
        self.window?.overrideUserInterfaceStyle = .dark
        self.window?.makeKeyAndVisible()
    }
    
    public func checkAunthentification() {
        
        if Auth.auth().currentUser == nil {
            self.goToController(with: WelcomeScreen())
        } else {
            self.goToController(with: MainTabarController())
        }
    }
    
    private func goToController(with viewController: UIViewController) {
        DispatchQueue.main.async { [weak self] in
            UIView.animate(withDuration: 0.25) {
                self?.window?.layer.opacity = 0
            } completion: { [weak self] _ in
                let nav = UINavigationController(rootViewController: viewController)
                nav.modalPresentationStyle = .fullScreen
                self?.window?.rootViewController = nav
                
                UIView.animate(withDuration: 0.25) { [weak self] in
                    self?.window?.layer.opacity = 1
                }
                print("Switched root view controller to: \(viewController)")
            }
        }
    }
}
