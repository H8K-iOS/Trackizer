import UIKit

final class AddNewUserViewController: UIViewController {
    // MARK: Constants
    weak var delegate: AddNewSpendViewControllerDelegate?

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
    
   
    private let closeButton = UIButton()
    
    
    
 
    private let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))

    // MARK: Variables
    private lazy var addNewUserTextField = createTextField(placeholder: "New user name")
    private lazy var continueButton = createButton(selector: #selector(continueButtonTapped))



    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        setupBackground()
        setupUI()
       
        
        // Add tap gesture recognizer to hide keyboard
        view.addGestureRecognizer(tapGesture)
        
       
        
    }

    // MARK: Methods
    @objc func continueButtonTapped() {
     
    }



    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc private func closeButtonTapped() {
        self.dismiss(animated: true)
    }

    

    private func addNewUser() {
        guard let spendsName = addNewUserTextField.text
              else {
            AlertManager.showAddSpendsErrorAlert(on: self)
            return
        }
        
        
    
    }


}

// MARK: - Extensions
private extension AddNewUserViewController {
    func setupBackground() {
        self.view.addSubview(blurContaienr)
        blurContaienr.effect = blurEffect
        
        NSLayoutConstraint.activate([
            blurContaienr.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            blurContaienr.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            blurContaienr.widthAnchor.constraint(equalToConstant: Constants.screenHeight / 2.7),
            blurContaienr.heightAnchor.constraint(equalToConstant: Constants.screenHeight / 2),
        ])
    }

    func setupUI() {
        self.view.addGestureRecognizer(tapGesture)
        self.view.addSubview(addNewUserTextField)
        addNewUserTextField.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(continueButton)
        self.view.addSubview(closeButton)
        closeButton.translatesAutoresizingMaskIntoConstraints = false

        
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        
        closeButton.setTitle("Close", for: .normal)
        closeButton.setTitleColor(.gray, for: .normal)
        closeButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .light)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        
        
      
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: blurContaienr.topAnchor, constant: 16),
            closeButton.leftAnchor.constraint(equalTo: blurContaienr.leftAnchor, constant: 16),
    
            addNewUserTextField.heightAnchor.constraint(equalToConstant: Constants.screenHeight / 15),
            addNewUserTextField.centerYAnchor.constraint(equalTo: blurContaienr.centerYAnchor),
            addNewUserTextField.leftAnchor.constraint(equalTo: blurContaienr.leftAnchor, constant: 16),
            addNewUserTextField.rightAnchor.constraint(equalTo: blurContaienr.rightAnchor, constant: -16),
            
            continueButton.bottomAnchor.constraint(equalTo: blurContaienr.bottomAnchor, constant: -16),
            continueButton.leftAnchor.constraint(equalTo: blurContaienr.leftAnchor, constant: 16),
            continueButton.rightAnchor.constraint(equalTo: blurContaienr.rightAnchor, constant: -16),
            continueButton.heightAnchor.constraint(equalToConstant: Constants.screenHeight / 15),
        ])
    }


}

// MARK: - UITextFieldDelegate
extension AddNewUserViewController: UITextFieldDelegate {
  
    
}
