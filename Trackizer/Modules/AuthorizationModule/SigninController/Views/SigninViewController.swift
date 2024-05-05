import UIKit


enum State {
    case signup
    case signin
}
final class SigninViewController: UIViewController {
    //MARK: Constants
    private let viewModel: SigninViewModel
    private let passwordRequirmentsLabel = UILabel()
    private let textFieldVStack = UIStackView()
    private let loginHStack = UIStackView()
    private let totalVStack = UIStackView()
    private let bottomVStack = UIStackView()
    private let forgotPasswordButton = UIButton()
    private let aboveButtonLabel = UILabel()
    
    private let username = ""
    private let email = ""
    private let password = ""
    
    //MARK: Variables
    private var viewControllerState = State.signin
    
    lazy var usernameTextField = createTextField(title: "Username", isSecure: false)
    lazy var emailTextField = createTextField(title: "E-mail address", isSecure: false)
    lazy var passwordTextField = createTextField(title: "Password", isSecure: true)
    
    //MARK: Lifecycle
    init(_ viewModel: SigninViewModel = SigninViewModel(),
         viewControllerState: State = State.signin
    ) {
        self.viewModel = viewModel
        self.viewControllerState = viewControllerState
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = GrayColors.gray80.OWColor
        
        navigationItem.titleView = createTrackizerLabel()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        switch viewControllerState {
        case .signup:
            navigationItem.title = "Sign up"
            setSignupViews()
            setSignupLayouts()
        case .signin:
            navigationItem.title = "Sign in"
            setSigninViews()
            setSigninLayouts()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Methods
    @objc private func forgotPasswordButtonTapped() {
        navigationController?.pushViewController(PasswordResetController(), animated: true)
    }
    
    @objc private func signinButtonTapped() {
        navigationController?.pushViewController(SigninViewController(viewControllerState: .signin), animated: true)
        
        print("signinButtonTapped")
    }
    
    @objc private func rememberPassword() {
        print("rememberPassword")
    }
    @objc private func signupButtonTapped() {
        navigationController?.pushViewController(SignupViewController(), animated: true)
    }
    
    @objc private func startButtonTapped() {
        
        viewModel.signup(username: usernameTextField.text ?? "",
                         email: emailTextField.text ?? "",
                         password: passwordTextField.text ?? "",
                         vc: self)
    }
    
}

//MARK: - Extensions
    //MARK: - Sign Up Extensions
private extension SigninViewController {
    func setSignupViews() {
        
        lazy var startButton = createButton(title: "Get started, it’s free!",
                                            selector: #selector(startButtonTapped),
                                            titleColor: GrayColors.white.OWColor,
                                            backgroundColor: AccentPrimarySection.accentP100.OWColor)
        lazy var signinButton = createButton(title: "Sign in",
                                             selector: #selector(signinButtonTapped),
                                             titleColor: GrayColors.white.OWColor,
                                             backgroundColor: GrayColors.gray80.OWColor)
        
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

    //MARK: - Sign In Extensions
private extension SigninViewController {
    func setSigninViews() {
        lazy var loginTextField = createTextField(title: "Login", isSecure: true)
        lazy var passwordTextField = createTextField(title: "Password", isSecure: true)
        
        lazy var rememberMeView = createRememberMeView(selector: #selector(rememberPassword))
        lazy var signinButton = createButton(title: "Sign in",
                                             selector: #selector(signinButtonTapped),
                                             titleColor: GrayColors.white.OWColor,
                                             backgroundColor: AccentPrimarySection.accentP100.OWColor)
        lazy var signupButton = createButton(title: "Sign up!",
                                             selector: #selector(signupButtonTapped),
                                             titleColor: GrayColors.white.OWColor,
                                             backgroundColor: GrayColors.gray70.OWColor)
        
        self.view.addSubview(textFieldVStack)
        self.view.addSubview(loginHStack)
        self.view.addSubview(totalVStack)
        self.view.addSubview(bottomVStack)
        self.view.addSubview(signupButton)
        self.view.addSubview(aboveButtonLabel)
        
        textFieldVStack.addArrangedSubview(loginTextField)
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
    func setSigninLayouts() {
        
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
