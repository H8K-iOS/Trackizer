import UIKit

final class SigninViewController: UIViewController, UITextFieldDelegate {
    // MARK: - Constants
    private let viewModel: SignViewModel
    private let textFieldVStack = UIStackView()
    private let loginHStack = UIStackView()
    private let totalVStack = UIStackView()
    private let bottomVStack = UIStackView()
    private let forgotPasswordButton = UIButton()
    private let aboveButtonLabel = UILabel()
    private let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    
    // MARK: - Variables
    lazy var emailTextField = createTextField(title: "Email", isSecure: false)
    lazy var passwordTextField = createTextField(title: "Password", isSecure: true)
    lazy var rememberMeView = createRememberMeView(selector: #selector(rememberPassword))
    lazy var signinButton = createButton(title: "Sign in",
                                         selector: #selector(signinButtonTapped),
                                         titleColor: GrayColors.white.OWColor,
                                         backgroundColor: AccentPrimarySection.accentP100.OWColor)
    lazy var signupButton = createButton(title: "Sign up!",
                                         selector: #selector(signupButtonTapped),
                                         titleColor: GrayColors.white.OWColor,
                                         backgroundColor: GrayColors.gray80.OWColor)
    
    // MARK: - Lifecycle
    init(viewModel: SignViewModel = SignViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sign in"
        setBackground()
        navigationItem.titleView = createTrackizerLabel()
        
        setupUI()
        setLayouts()
        
        // Set delegates for text fields
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        // Add tap gesture recognizer to dismiss keyboard
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    @objc private func forgotPasswordButtonTapped() {
        navigationController?.pushViewController(PasswordResetController(), animated: true)
    }
    
    @objc private func signinButtonTapped() {
        guard let email = emailTextField.text,
              let password = passwordTextField.text else { return }
        
        viewModel.signIn(email: email, password: password, vc: self) { [weak self] error in
            if let error {
                AlertManager.showSigninErrorAlert(on: self ?? UIViewController(), with: error)
            } else {
                if let sceneDelegate = self?.view.window?.windowScene?.delegate as? SceneDelegate {
                    sceneDelegate.checkAunthentification()
                }
            }
        }
    }
    
    @objc private func signupButtonTapped() {
        navigationController?.pushViewController(SignupViewController(), animated: true)
    }
    
    @objc private func rememberPassword() {
        switch rememberMeView.backgroundColor {
        case .white:
            rememberMeView.backgroundColor = .clear
        case .clear:
            rememberMeView.backgroundColor = .white
        default:
            break
        }
    }
    
    @objc private func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == passwordTextField {
            signinButtonTapped()
        }
        return true
    }
}

// MARK: - Extensions
private extension SigninViewController {
    func setupUI() {
        self.view.addGestureRecognizer(tapGesture)
        self.view.addSubview(textFieldVStack)
        self.view.addSubview(loginHStack)
        self.view.addSubview(totalVStack)
        self.view.addSubview(bottomVStack)
        self.view.addSubview(signupButton)
        self.view.addSubview(aboveButtonLabel)
        
        textFieldVStack.addArrangedSubview(emailTextField)
        textFieldVStack.addArrangedSubview(passwordTextField)
        loginHStack.addArrangedSubview(rememberMeView)
        loginHStack.addArrangedSubview(forgotPasswordButton)
        
        totalVStack.addArrangedSubview(textFieldVStack)
        totalVStack.addArrangedSubview(loginHStack)
        totalVStack.addArrangedSubview(signinButton)
        
        bottomVStack.addArrangedSubview(aboveButtonLabel)
        bottomVStack.addArrangedSubview(signupButton)
        
        loginHStack.translatesAutoresizingMaskIntoConstraints = false
        textFieldVStack.translatesAutoresizingMaskIntoConstraints = false
        totalVStack.translatesAutoresizingMaskIntoConstraints = false
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        aboveButtonLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomVStack.translatesAutoresizingMaskIntoConstraints = false
        
        textFieldVStack.axis = .vertical
        textFieldVStack.distribution = .fillEqually
        textFieldVStack.spacing = 34
        
        loginHStack.axis = .horizontal
        loginHStack.distribution = .equalSpacing
        
        forgotPasswordButton.setTitle("Forgot password", for: .normal)
        forgotPasswordButton.setTitleColor(GrayColors.gray50.OWColor, for: .normal)
        forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordButtonTapped), for: .touchUpInside)
        forgotPasswordButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        
        totalVStack.axis = .vertical
        totalVStack.spacing = 20
        totalVStack.distribution = .equalSpacing
        
        bottomVStack.axis = .vertical
        bottomVStack.spacing = 16
        bottomVStack.alignment = .center
        
        signupButton.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 16).isActive = true
        signupButton.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -16).isActive = true
        
        aboveButtonLabel.text = "If you don't have an account yet"
        aboveButtonLabel.font = .systemFont(ofSize: 16)
        aboveButtonLabel.textColor = GrayColors.white.OWColor
    }
    
    func setLayouts() {
        NSLayoutConstraint.activate([
            loginHStack.topAnchor.constraint(equalTo: textFieldVStack.bottomAnchor, constant: 24),
            loginHStack.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            loginHStack.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            
            totalVStack.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            totalVStack.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            totalVStack.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            
            bottomVStack.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            bottomVStack.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            bottomVStack.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -16),
        ])
    }
}
