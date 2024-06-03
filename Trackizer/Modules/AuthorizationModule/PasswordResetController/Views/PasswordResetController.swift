import UIKit

final class PasswordResetController: UIViewController {
    //MARK: Constants
    private let resetVStack = UIStackView()
    
    //MARK: Variables
    
    private lazy var resetPasswordButton = createButton(title: "Reset password!",
                                                        selector: #selector(resetPasswordButtonTapped),
                                                        backgroundColor: GrayColors.gray100.OWColor)
    private lazy var emailTextField = createTextField()
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = GrayColors.gray80.OWColor
        
        navigationItem.titleView = createTrackizerLabel()
        navigationItem.title = "Forgot password?"
        
        setViews()
        setLayouts()
    }
    //MARK: Mathods
    
    @objc private func resetPasswordButtonTapped() {
        let email = self.emailTextField.text ?? ""
        if !ValidationManager.isValidEmail(for: email) {
            AlertManager.showInvalidEmailAlert(on: self)
        }
            
        AuthService.shared.forgotPassword(with: email) { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                AlertManager.showErrorSendingPasswordReset(on: self, with: error)
                return
            }
            
            AlertManager.showPasswordResetSent(on: self)
        }
    }
}

//MARK: - Extensions
private extension PasswordResetController {
    func setViews() {
        self.view.addSubview(resetPasswordButton)
        self.view.addSubview(emailTextField)
        
        self.view.addSubview(resetVStack)
        resetVStack.addArrangedSubview(emailTextField)
        resetVStack.addArrangedSubview(resetPasswordButton)
        resetPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        resetVStack.translatesAutoresizingMaskIntoConstraints = false
        
        resetVStack.axis = .vertical
        resetVStack.spacing = 16
        //resetVStack.distribution =
        
       
}
    
    func setLayouts() {
        NSLayoutConstraint.activate([
            resetVStack.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 80),
            resetVStack.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            resetVStack.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -16),
        ])
    }
}


