import UIKit

final class SignupViewController: UIViewController {
    //MARK: Constants
    private let appleIcon = UIImage(#imageLiteral(resourceName: "appleIcon"))
    private let googleIcon = UIImage(#imageLiteral(resourceName: "googleIcon"))
    private let facebookIcon = UIImage(#imageLiteral(resourceName: "facebookIcon"))
    private let separationLabel = UILabel()
    private let socialMediaButtonsVStack = UIStackView()
    private let totalVStack = UIStackView()
    private let iconSpacing: CGFloat = 10
    private let termsOfUseTextView: UITextView = {
        let attributedString = NSMutableAttributedString(string: "By registering, you agree to our Terms of Use. Learn how we collect, use and share your data.")
        attributedString.addAttribute(.link, value: "terms://TermsOfUse", range: (attributedString.string as NSString).range(of: "Terms of Use"))
        
        let tv = UITextView()
        tv.linkTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemBlue.withAlphaComponent(0.7)]
        tv.attributedText = attributedString
        tv.backgroundColor = .clear
        tv.isSelectable = true
        tv.isEditable = false
        tv.isScrollEnabled = false
        tv.textColor = GrayColors.gray50.OWColor
        tv.delaysContentTouches = false
        tv.font = .systemFont(ofSize: 12)
        tv.textAlignment = .center
        
        return tv
    }()
    
    //MARK: Variables
    private lazy var signupAppleButton = createSignupButton(title: "Sign up with Apple",
                                                            icon: appleIcon,
                                                            selector: #selector(signupAppleButtonTapped),
                                                            tintColor: GrayColors.white.OWColor,
                                                            titleColor: GrayColors.white.OWColor,
                                                            backgroundColor: .black)
    private lazy var signupGoogleButton = createSignupButton(title: "Sign up with Google",
                                                            icon: googleIcon,
                                                            selector: #selector(signupGoogleButtonTapped),
                                                            tintColor: .black,
                                                            titleColor: .black,
                                                             backgroundColor: GrayColors.white.OWColor)
    private lazy var signupFacebookButton = createSignupButton(title: "Sign up with Facebook",
                                                            icon: facebookIcon,
                                                            selector: #selector(signupFacebookButtonTapped),
                                                            tintColor: GrayColors.white.OWColor,
                                                            titleColor: GrayColors.white.OWColor,
                                                            backgroundColor: .blue)
    private lazy var signupEmailButton = createSignupButton(title: "Sign up with E-mail",
                                                            icon: nil,
                                                            selector: #selector(signupEmailButtonTapped),
                                                            tintColor: GrayColors.white.OWColor,
                                                            titleColor: GrayColors.white.OWColor,
                                                            backgroundColor: GrayColors.gray100.OWColor)
   
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sign up"
        self.view.backgroundColor = GrayColors.gray80.OWColor
        setViews()
        setLayouts()
        navigationItem.titleView = createTrackizerLabel()
        
        self.termsOfUseTextView.delegate = self
    }
    
    //MARK: Methods
    @objc private func signupAppleButtonTapped() {
        print("signupAppleButtonTapped")
    }
    @objc private func signupGoogleButtonTapped() {
        print("signupGoogleButtonTapped")
    }
    @objc private func signupFacebookButtonTapped() {
        print("signupFacebookButtonTapped")
    }
    @objc private func signupEmailButtonTapped() {
        
        navigationController?.pushViewController(SigninViewController(viewControllerState: .signup), animated: true)
    }
    
}

//MARK: - Extensions
private extension SignupViewController {
    //MARK: Views
    func setViews() {
        self.view.addSubview(socialMediaButtonsVStack)
        self.view.addSubview(totalVStack)
        self.view.addSubview(separationLabel)
        self.view.addSubview(termsOfUseTextView)
        
        socialMediaButtonsVStack.addArrangedSubview(signupAppleButton)
        socialMediaButtonsVStack.addArrangedSubview(signupGoogleButton)
        socialMediaButtonsVStack.addArrangedSubview(signupFacebookButton)
        
    
        
        totalVStack.addArrangedSubview(socialMediaButtonsVStack)
        totalVStack.addArrangedSubview(separationLabel)
        totalVStack.addArrangedSubview(signupEmailButton)
        totalVStack.addArrangedSubview(termsOfUseTextView)

        socialMediaButtonsVStack.translatesAutoresizingMaskIntoConstraints = false
        totalVStack.translatesAutoresizingMaskIntoConstraints = false
        separationLabel.translatesAutoresizingMaskIntoConstraints = false
        termsOfUseTextView.translatesAutoresizingMaskIntoConstraints = false
        
        socialMediaButtonsVStack.axis = .vertical
        socialMediaButtonsVStack.spacing = 18
        socialMediaButtonsVStack.distribution = .fillEqually
        
        totalVStack.axis = .vertical
        totalVStack.spacing = 20
        totalVStack.distribution = .equalSpacing
        totalVStack.backgroundColor = .clear
        totalVStack.alignment = .center
    
        separationLabel.text = "or"
        
        
        
    }
    
    //MARK: Layouts
    func setLayouts() {
        NSLayoutConstraint.activate([
            totalVStack.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            
            totalVStack.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            
            totalVStack.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            
            totalVStack.heightAnchor.constraint(equalToConstant: 375),
            
            
            signupAppleButton.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            signupAppleButton.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            

            
            signupEmailButton.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            signupEmailButton.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            

            
            separationLabel.heightAnchor.constraint(equalToConstant: 20),
            termsOfUseTextView.heightAnchor.constraint(equalToConstant: 32)
        ])
        
    }
}
    //MARK: UITextViewDelegate
extension SignupViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if URL.scheme == "terms" {
            self.showWebViewerController(with: "https://policies.google.com/terms?hl=en")
        }
        
        return true
    }
    
    private func showWebViewerController(with urlString: String) {
        let vc = UINavigationController(rootViewController: WebViewerController(with: urlString))
        self.present(vc, animated: true)
    }
}
