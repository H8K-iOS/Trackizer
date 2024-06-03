import UIKit

final class WelcomeScreen: UIViewController {
    //MARK: Constants
    private let backgroundView = BackgroundView()
    private let leftEffectImage = UIImageView(image: #imageLiteral(resourceName: "idkwhatisthis"))
    private let rightEffectImage = UIImageView(image: #imageLiteral(resourceName: "Image.png"))
    private let descriptionLabel = UILabel()
    private let buttonVStack = UIStackView()
    private let startButton = UIButton()
    private let loginButton = UIButton()
    private let rightSideLightView = UIView()
    private let leftSideLightView = UIView()
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = GrayColors.gray100.OWColor
        
        setViews()
        setLayouts()
        navigationItem.title = ""
        navigationItem.titleView = createTrackizerLabel()
    }
    
    deinit {
        print("Welcome screen")
    }
    //MARK: Methods
    @objc private func startButtonTapped() {
        navigationController?.pushViewController(SignupWithViewController(), animated: true)
        
    }
    
    @objc private func loginButtonTapped() {
        navigationController?.pushViewController(SigninViewController(), animated: true)
        
    }
}

//MARK: - Extensions
private extension WelcomeScreen {
    //MARK: Views
    func setViews() {
        self.view.addSubview(leftEffectImage)
        self.view.addSubview(rightEffectImage)
        self.view.addSubview(descriptionLabel)
        self.view.addSubview(buttonVStack)
        self.view.addSubview(startButton)
        self.view.addSubview(loginButton)
        self.view.addSubview(backgroundView)
    
        buttonVStack.addArrangedSubview(startButton)
        buttonVStack.addArrangedSubview(loginButton)
    
        leftEffectImage.translatesAutoresizingMaskIntoConstraints = false
        rightEffectImage.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        buttonVStack.translatesAutoresizingMaskIntoConstraints = false
        startButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.translatesAutoresizingMaskIntoConstraints = false

        descriptionLabel.text = "Spend, enjoy, distribute!"
        descriptionLabel.font = .systemFont(ofSize: 24)
        descriptionLabel.backgroundColor = .clear
        descriptionLabel.textAlignment = .center
        
        leftEffectImage.contentMode = .scaleAspectFit
        
        buttonVStack.axis = .vertical
        buttonVStack.spacing = 14
        buttonVStack.distribution = .fillEqually
        
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        startButton.setTitle("Get started", for: .normal)
        startButton.setTitleColor(.white, for: .normal)
        startButton.titleLabel?.font = .systemFont(ofSize: 16)
        startButton.backgroundColor = AccentPrimarySection.accentP100.OWColor
        startButton.layer.cornerRadius = 24
        startButton.layer.borderColor = GrayColors.white.OWColor.cgColor
        startButton.layer.shadowColor = GrayColors.white.OWColor.cgColor
        startButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        startButton.layer.shadowOpacity = 0.5
        startButton.layer.shadowRadius = 10
        
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        loginButton.setTitle("I have an account", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.titleLabel?.font = .systemFont(ofSize: 16)
        loginButton.backgroundColor = GrayColors.gray70.OWColor
        loginButton.layer.cornerRadius = 24
        loginButton.layer.borderColor = GrayColors.white.OWColor.cgColor
        loginButton.layer.shadowColor = GrayColors.gray100.OWColor.cgColor
        loginButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        loginButton.layer.shadowOpacity = 0.5
        loginButton.layer.shadowRadius = 10
        
        //MARK: Light Elements
        self.view.addSubview(rightSideLightView)
        rightSideLightView.translatesAutoresizingMaskIntoConstraints = false
        rightSideLightView.backgroundColor = GrayColors.gray80.OWColor
        rightSideLightView.layer.cornerRadius = 140
        rightSideLightView.layer.shadowColor = AccentPrimarySection.accentP100.OWColor.cgColor
        rightSideLightView.layer.shadowOffset = CGSize(width: -20, height: 20)
        rightSideLightView.layer.shadowOpacity = 10
        rightSideLightView.layer.shadowRadius = 50
        
        self.view.addSubview(leftSideLightView)
        leftSideLightView.translatesAutoresizingMaskIntoConstraints = false
        leftSideLightView.backgroundColor = GrayColors.gray80.OWColor
        leftSideLightView.layer.cornerRadius = 140
        leftSideLightView.layer.shadowColor = AccentPrimarySection.accentP100.OWColor.cgColor
        leftSideLightView.layer.shadowOffset = CGSize(width: 50, height: 20)
        leftSideLightView.layer.shadowOpacity = 10
        leftSideLightView.layer.shadowRadius = 50
    }
    
    //MARK: Layouts
    func setLayouts() {
        NSLayoutConstraint.activate([
            rightSideLightView.widthAnchor.constraint(equalToConstant: 299),
            rightSideLightView.heightAnchor.constraint(equalToConstant: 202),
            rightSideLightView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
            rightSideLightView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -150),
            
            leftSideLightView.widthAnchor.constraint(equalToConstant: 299),
            leftSideLightView.heightAnchor.constraint(equalToConstant: 202),
            leftSideLightView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            leftSideLightView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: -20),
            
            leftEffectImage.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30),
            leftEffectImage.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 65),
            
            rightEffectImage.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: 0),
            rightEffectImage.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 180),
            
            backgroundView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            backgroundView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -80),
            
            descriptionLabel.bottomAnchor.constraint(equalTo: buttonVStack.topAnchor, constant: -32),
            descriptionLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            descriptionLabel.widthAnchor.constraint(equalToConstant: 290),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 40),
            
            buttonVStack.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -26),
            buttonVStack.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            buttonVStack.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -16),
        
            startButton.heightAnchor.constraint(equalToConstant: 52),
        ])
    }
}
