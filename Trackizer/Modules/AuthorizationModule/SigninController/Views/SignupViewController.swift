import UIKit

final class SignupViewController: UIViewController {
    //MARK: Constants
    private let viewModel: SignViewModel
    private let textFieldVStack = UIStackView()
    private let loginHStack = UIStackView()
    private let totalVStack = UIStackView()
    private let bottomVStack = UIStackView()
    private let aboveButtonLabel = UILabel()
    
    //MARK: Variables
    lazy var usernameTextField = createTextField(title: "Username", isSecure: false)
    lazy var emailTextField = createTextField(title: "E-mail address", isSecure: false)
    lazy var passwordTextField = createTextField(title: "Password", isSecure: true)
    
    
    lazy var startButton = createButton(title: "Get started, it’s free!",
                                        selector: #selector(startButtonTapped),
                                        titleColor: GrayColors.white.OWColor,
                                        backgroundColor: AccentPrimarySection.accentP100.OWColor)
    lazy var signinButton = createButton(title: "Sign in",
                                         selector: #selector(signinRegistrationButtonTapped),
                                         titleColor: GrayColors.white.OWColor,
                                         backgroundColor: GrayColors.gray80.OWColor)
    
    //MARK: Lifecycle
    init(_ viewModel: SignViewModel = SignViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        self.title = "Sign up"
        navigationItem.titleView = createTrackizerLabel()
        navigationController?.navigationBar.prefersLargeTitles = true
        setSignupViews()
        setSignupLayouts()
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Methods
    
    @objc private func signinRegistrationButtonTapped() {
        navigationController?.pushViewController(SigninViewController(), animated: true)
    }

    @objc private func startButtonTapped() {
        guard let username = usernameTextField.text,
              let email = emailTextField.text,
              let password = passwordTextField.text else {
            return
        }
        
        viewModel.signup(username: username, email: email, password: password, vc: self) { [weak self] error in
            if let error {
                AlertManager.showRegistrationErrorAlert(on: self ?? UIViewController(), with: error)
            } else {
                if let sceneDelegate = self?.view.window?.windowScene?.delegate as? SceneDelegate {
                    sceneDelegate.checkAunthentification()
                }
            }
        }
        
    }
    
}

//MARK: - Extensions
    //MARK: - Sign Up Extensions
private extension SignupViewController {
    func setSignupViews() {
        self.view.addSubview(textFieldVStack)
        textFieldVStack.addArrangedSubview(usernameTextField)
        textFieldVStack.addArrangedSubview(emailTextField)
        textFieldVStack.addArrangedSubview(passwordTextField)
        
        self.view.addSubview(totalVStack)
        totalVStack.addArrangedSubview(textFieldVStack)
        totalVStack.addArrangedSubview(startButton)
        
        self.view.addSubview(bottomVStack)
        bottomVStack.addArrangedSubview(aboveButtonLabel)
        bottomVStack.addArrangedSubview(signinButton)
        
        textFieldVStack.translatesAutoresizingMaskIntoConstraints = false
        totalVStack.translatesAutoresizingMaskIntoConstraints = false
        bottomVStack.translatesAutoresizingMaskIntoConstraints = false
        
        textFieldVStack.axis = .vertical
        textFieldVStack.distribution = .fillEqually
        textFieldVStack.spacing = 34
        
        totalVStack.axis = .vertical
        totalVStack.spacing = 26
        
        bottomVStack.axis = .vertical
        bottomVStack.spacing = 16
        bottomVStack.alignment = .center
        
        aboveButtonLabel.text = "Do you have already an account?"
        aboveButtonLabel.font = .systemFont(ofSize: 16)
        aboveButtonLabel.textColor = GrayColors.white.OWColor
        
        signinButton.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 16).isActive = true
        signinButton.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -16).isActive = true
    }
    func setSignupLayouts() {
        NSLayoutConstraint.activate([
            
            totalVStack.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            totalVStack.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            totalVStack.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            
            bottomVStack.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            bottomVStack.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            bottomVStack.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -16),
        ])
    }
}
