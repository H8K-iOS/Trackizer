import UIKit

final class WelcomeScreen: UIViewController {
    //MARK: Constants
    let backgroundView = BackgroundView()
    
    private let labelHStack = UIStackView()
    private let trackizerLabel = UILabel()
    private let trackizerIcon = UIImageView(image: #imageLiteral(resourceName: "trackiezer"))
    
    private let leftEffectImage = UIImageView(image: #imageLiteral(resourceName: "idkwhatisthis"))
    private let rightEffectImage = UIImageView(image: #imageLiteral(resourceName: "Image.png"))
    private let descriptionLabel = UILabel()
    
    
    private let buttonVStack = UIStackView()
    private let startButton = UIButton()
    private let loginButton = UIButton()
    
    let testLightView = UIView()
    let testLightView1 = UIView()
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = GrayColors.gray80.OWColor
        
        setViews()
        setLayouts()
    }
    
    //MARK: Methods
}

//MARK: - Extensions
private extension WelcomeScreen {
    func setViews() {
        self.view.addSubview(labelHStack)
        self.view.addSubview(trackizerLabel)
        self.view.addSubview(trackizerIcon)
        
        self.view.addSubview(leftEffectImage)
        self.view.addSubview(rightEffectImage)
      
        self.view.addSubview(descriptionLabel)
        self.view.addSubview(buttonVStack)
        self.view.addSubview(startButton)
        self.view.addSubview(loginButton)
        self.view.addSubview(backgroundView)
        
        
        
        labelHStack.addArrangedSubview(trackizerIcon)
        labelHStack.addArrangedSubview(trackizerLabel)
        
        buttonVStack.addArrangedSubview(startButton)
        buttonVStack.addArrangedSubview(loginButton)
        
        labelHStack.translatesAutoresizingMaskIntoConstraints = false
        trackizerLabel.translatesAutoresizingMaskIntoConstraints = false
        trackizerIcon.translatesAutoresizingMaskIntoConstraints = false
        
        leftEffectImage.translatesAutoresizingMaskIntoConstraints = false
        rightEffectImage.translatesAutoresizingMaskIntoConstraints = false
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        buttonVStack.translatesAutoresizingMaskIntoConstraints = false
        startButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        
        labelHStack.axis = .horizontal
        labelHStack.spacing = 0
        labelHStack.distribution = .equalSpacing
        
        trackizerLabel.text = "trackizer".uppercased()
        trackizerLabel.font = .systemFont(ofSize: 26, weight: .medium)
        trackizerLabel.textColor = .white
        
        trackizerIcon.contentMode = .scaleAspectFit
        
        descriptionLabel.text = "Spend, enjoy, distribute!"
        descriptionLabel.font = .systemFont(ofSize: 24)
        descriptionLabel.backgroundColor = .clear
        descriptionLabel.textAlignment = .center
        
        leftEffectImage.contentMode = .scaleAspectFit
        
        buttonVStack.axis = .vertical
        buttonVStack.spacing = 14
        buttonVStack.distribution = .fillEqually
        
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
        
        
        
        
        self.view.addSubview(testLightView)
        testLightView.translatesAutoresizingMaskIntoConstraints = false
        testLightView.backgroundColor = GrayColors.gray80.OWColor
        testLightView.layer.cornerRadius = 140
        testLightView.layer.shadowColor = AccentPrimarySection.accentP100.OWColor.cgColor
        testLightView.layer.shadowOffset = CGSize(width: -20, height: 20)
        testLightView.layer.shadowOpacity = 10
        testLightView.layer.shadowRadius = 50
        
        self.view.addSubview(testLightView1)
        testLightView1.translatesAutoresizingMaskIntoConstraints = false
        testLightView1.backgroundColor = GrayColors.gray80.OWColor
        testLightView1.layer.cornerRadius = 140
        testLightView1.layer.shadowColor = AccentPrimarySection.accentP100.OWColor.cgColor
        testLightView1.layer.shadowOffset = CGSize(width: 50, height: 20)
        testLightView1.layer.shadowOpacity = 10
        testLightView1.layer.shadowRadius = 50
    }
    
    func setLayouts() {
        NSLayoutConstraint.activate([
            testLightView.widthAnchor.constraint(equalToConstant: 299),
            testLightView.heightAnchor.constraint(equalToConstant: 202),
            testLightView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
            testLightView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -150),
            
            testLightView1.widthAnchor.constraint(equalToConstant: 299),
            testLightView1.heightAnchor.constraint(equalToConstant: 202),
            testLightView1.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            testLightView1.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: -20),
            
            leftEffectImage.topAnchor.constraint(equalTo: labelHStack.bottomAnchor, constant: 50),
            leftEffectImage.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 65),
            
            rightEffectImage.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: 0),
            rightEffectImage.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 180),
            
            labelHStack.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16),
            labelHStack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            labelHStack.widthAnchor.constraint(equalToConstant: 178),
            labelHStack.heightAnchor.constraint(equalToConstant: 29),
            
            backgroundView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            backgroundView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -80),
            
            descriptionLabel.bottomAnchor.constraint(equalTo: buttonVStack.topAnchor, constant: -32),
            descriptionLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            descriptionLabel.widthAnchor.constraint(equalToConstant: 290),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 40),
            
            buttonVStack.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -26),
            buttonVStack.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            buttonVStack.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -16),
        
            startButton.heightAnchor.constraint(equalToConstant: 48),
    
            
        ])
    }
}
