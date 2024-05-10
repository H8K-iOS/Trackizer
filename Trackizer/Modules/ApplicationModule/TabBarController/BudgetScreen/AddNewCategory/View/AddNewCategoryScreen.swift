import UIKit

final class AddNewCategoryViewController: UIViewController {
    //MARK: Constants
    private let blurEffect = UIBlurEffect(style: .dark)
    private let blurContaienr: UIVisualEffectView = {
        let view = UIVisualEffectView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 24
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.darkGray.cgColor
        view.backgroundColor = .clear
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var continueButton = createButton(selector: #selector(continueButtonTapped))
    //MARK: Variables
    init() {
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overCurrentContext
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .clear
        setupBackground()
        setupUI()
    }
    //MARK: Methods
    
    @objc func continueButtonTapped() {
        self.dismiss(animated: true)
    }
}

//MARK: - Extensions
private extension AddNewCategoryViewController {
    func setupBackground() {
        self.view.addSubview(blurContaienr)
        self.view.addSubview(continueButton)
        blurContaienr.effect = blurEffect
        
        NSLayoutConstraint.activate([
        
            blurContaienr.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            blurContaienr.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            
            blurContaienr.widthAnchor.constraint(equalToConstant: 330),
            blurContaienr.heightAnchor.constraint(equalToConstant: 500),
        ])
    }
    
    
    func setupUI() {
        
        
        NSLayoutConstraint.activate([
        
            continueButton.bottomAnchor.constraint(equalTo: blurContaienr.bottomAnchor, constant: -16),
            continueButton.leftAnchor.constraint(equalTo: blurContaienr.leftAnchor, constant: 16),
            continueButton.rightAnchor.constraint(equalTo: blurContaienr.rightAnchor, constant: -16),
            continueButton.heightAnchor.constraint(equalToConstant: 52)

        ])
    }
}
