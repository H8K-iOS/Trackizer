import UIKit


//MARK: - UIViewController
extension UIViewController {
    func setBackground() {
        self.view.backgroundColor = GrayColors.gray80.OWColor
    }
    
    func createTrackizerLabel() -> UIView {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        
        let labelHStack = UIStackView()
        let trackizerLabel = UILabel()
        let trackizerIcon = UIImageView(image: #imageLiteral(resourceName: "trackiezer"))
        
        self.view.addSubview(labelHStack)
        self.view.addSubview(trackizerLabel)
        self.view.addSubview(trackizerIcon)
        
        labelHStack.addArrangedSubview(trackizerIcon)
        labelHStack.addArrangedSubview(trackizerLabel)
        
        labelHStack.translatesAutoresizingMaskIntoConstraints = false
        trackizerLabel.translatesAutoresizingMaskIntoConstraints = false
        trackizerIcon.translatesAutoresizingMaskIntoConstraints = false
        
        labelHStack.axis = .horizontal
        labelHStack.spacing = 0
        labelHStack.distribution = .equalSpacing
        
        trackizerLabel.text = "trackizer".uppercased()
        trackizerLabel.font = .systemFont(ofSize: 26, weight: .medium)
        trackizerLabel.textColor = .white
        
        trackizerIcon.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            labelHStack.widthAnchor.constraint(equalToConstant: 178),
            labelHStack.heightAnchor.constraint(equalToConstant: 29)
        ])

        
        labelHStack.addGestureRecognizer(tapGesture)
        labelHStack.isUserInteractionEnabled = true
        
        return labelHStack
    }
    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        if let navigationController = self.navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
}

//MARK: - Sign Up ViewController
extension SignupViewController {
    func createSignupButton(title: String, icon: UIImage?, selector: Selector, tintColor: UIColor, titleColor: UIColor, backgroundColor: UIColor) -> UIButton {
        let btn = UIButton()
        let tintedIcon = icon?.withRenderingMode(.alwaysTemplate)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(titleColor, for: .normal)
        btn.setImage(tintedIcon, for: .normal)
        btn.tintColor = tintColor
        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        btn.backgroundColor = backgroundColor
        btn.layer.cornerRadius = 22
        btn.layer.borderColor = GrayColors.gray70.OWColor.cgColor
        btn.layer.borderWidth = 1
        btn.layer.shadowColor = GrayColors.white.OWColor.cgColor
        btn.layer.shadowOffset = CGSize(width: 0, height: 1)
        btn.layer.shadowOpacity = 0.5
        btn.layer.shadowRadius = 5
        
        btn.heightAnchor.constraint(equalToConstant: 56).isActive = true
        
        btn.addTarget(self, action: selector, for: .touchUpInside)
        return btn
    }
    
}

//MARK: - Sign In ViewController
extension SigninViewController {
    func createTextField(title: String, isSecure: Bool) -> UITextField {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = title
        label.textColor = GrayColors.gray50.OWColor
        
        
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = .clear
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 22
        tf.layer.borderColor = GrayColors.gray70.OWColor.cgColor
        tf.autocapitalizationType = .none
        tf.isSecureTextEntry = isSecure
       
        tf.addSubview(label)
        self.view.addSubview(tf)
        
        NSLayoutConstraint.activate([
            label.bottomAnchor.constraint(equalTo: tf.topAnchor, constant: -5),
            label.leftAnchor.constraint(equalTo: tf.leftAnchor, constant: 4),
            

            tf.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            tf.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            tf.heightAnchor.constraint(equalToConstant: 68)
        ])
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        tf.leftView = paddingView
        tf.leftViewMode = .always
            
        return tf
    }
    
    func createRememberMeView(selector: Selector) -> UIButton {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Remember me"
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = GrayColors.gray50.OWColor
        
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .clear
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 8
        btn.layer.borderColor = GrayColors.gray70.OWColor.cgColor
        btn.addSubview(label)
        self.view.addSubview(btn)
        
        
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: btn.rightAnchor, constant: 5),
            label.centerYAnchor.constraint(equalTo: btn.centerYAnchor),

            btn.widthAnchor.constraint(equalToConstant: 24),
            btn.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        btn.addTarget(self, action: selector, for: .touchUpInside)
        return btn
    }
    
    func createButton(title: String, selector: Selector,titleColor: UIColor, backgroundColor: UIColor) -> UIButton {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(titleColor, for: .normal)
        btn.backgroundColor = backgroundColor
        btn.layer.cornerRadius = 22
        btn.layer.borderColor = GrayColors.gray70.OWColor.cgColor
        btn.layer.borderWidth = 1
        btn.layer.shadowColor = GrayColors.white.OWColor.cgColor
        btn.layer.shadowOffset = CGSize(width: 0, height: 1)
        btn.layer.shadowOpacity = 0.5
        btn.layer.shadowRadius = 5
        
        btn.heightAnchor.constraint(equalToConstant: 52).isActive = true
        
        
        btn.addTarget(self, action: selector, for: .touchUpInside)
        return btn
        
    }
}

//MARK: - Password Reset ViewController
extension PasswordResetController {
    func createButton(title: String, selector: Selector, backgroundColor: UIColor) -> UIButton {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(GrayColors.white.OWColor, for: .normal)
        btn.backgroundColor = backgroundColor
        btn.layer.cornerRadius = 22
        btn.layer.borderColor = GrayColors.gray70.OWColor.cgColor
        btn.layer.borderWidth = 1
        btn.layer.shadowColor = GrayColors.white.OWColor.cgColor
        btn.layer.shadowOffset = CGSize(width: 0, height: 1)
        btn.layer.shadowOpacity = 0.5
        btn.layer.shadowRadius = 5
        
        btn.heightAnchor.constraint(equalToConstant: 52).isActive = true
        
        
        btn.addTarget(self, action: selector, for: .touchUpInside)
        return btn
        
    }
    
    func createTextField() -> UITextField {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = .clear
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 22
        tf.layer.borderColor = GrayColors.gray70.OWColor.cgColor
        tf.placeholder = "Enter your e-mail address"
       
        self.view.addSubview(tf)
        
        NSLayoutConstraint.activate([
            tf.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            tf.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            tf.heightAnchor.constraint(equalToConstant: 68)
        ])
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        tf.leftView = paddingView
        tf.leftViewMode = .always
            
        return tf
    }
}

//MARK: - Budget ViewController

extension BudgetViewController {
    enum ButtonType {
        case budget
        case category
    }
    
    func createButton(type: ButtonType,selector: Selector) -> UIButton {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "addIcon"), for: .normal)
        btn.addTarget(self, action: selector, for: .touchUpInside)
        
        switch type {
            
        case .budget:
            btn.tintColor = .systemGray
            btn.setTitle("Add spends", for: .normal)
            
            
            btn.layer.cornerRadius = 15
            btn.layer.borderWidth = 1
            btn.layer.borderColor = UIColor.darkGray.cgColor
            
            NSLayoutConstraint.activate([
                btn.heightAnchor.constraint(equalToConstant: 60),
            ])
        case .category:
            btn.tintColor = .systemGray
            btn.setTitle("Add new category", for: .normal)
            btn.layer.cornerRadius = 15
            btn.layer.borderWidth = 1
            btn.layer.borderColor = UIColor.darkGray.cgColor
            
            NSLayoutConstraint.activate([
                
                btn.heightAnchor.constraint(equalToConstant: 84),
            ])
        }
        
        
        
        return btn
    }
    
}


