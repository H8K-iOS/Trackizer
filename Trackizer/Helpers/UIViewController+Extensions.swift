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
    
    func createRoundButton(imageName: String, selector: Selector) -> UIButton{
        let btn = UIButton()
        btn.setImage(UIImage(systemName: imageName)?.withRenderingMode(.alwaysTemplate),
                     for: .normal)
        btn.contentVerticalAlignment = .center
        btn.contentHorizontalAlignment = .center
        btn.tintColor = .white
        btn.backgroundColor = .clear
        btn.layer.cornerRadius = 15
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.gray.withAlphaComponent(0.4).cgColor
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.widthAnchor.constraint(equalToConstant: 40).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btn.addTarget(self, action: selector, for: .touchUpInside)
       
        return btn
    }

}

//MARK: - Sign Up ViewController
extension SignupWithViewController {
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
        self.view.addSubview(btn)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .clear
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 8
        btn.layer.borderColor = GrayColors.gray70.OWColor.cgColor
        btn.addSubview(label)
        
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

//MARK: - Sign In ViewController
extension SignupViewController {
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
    
    enum Budget {
        case description
        case budget
    }
    
    func createButton(type: ButtonType,selector: Selector) -> UIButton {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "addIcon"), for: .normal)
        btn.addTarget(self, action: selector, for: .touchUpInside)
        btn.tintColor = .systemGray
        btn.layer.cornerRadius = 15
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.darkGray.cgColor
        
        switch type {
        case .budget:
            btn.setTitle("Add spends", for: .normal)

            NSLayoutConstraint.activate([
                btn.heightAnchor.constraint(equalToConstant: 60),
            ])
        case .category:
            btn.setTitle("Add new category", for: .normal)
            
            NSLayoutConstraint.activate([
                btn.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 11),
            ])
        }
        return btn
    }
    
    func createLabel(of amount: Double?, type: Budget) -> UILabel {
        let label = UILabel()
        
        switch type {
        case .description:
            label.text = "of $\(amount?.rounded(toPlaces: 2) ?? 0) budget"
            label.font = .systemFont(ofSize: 16, weight: .medium)
            label.textColor = .darkGray
        case .budget:
            label.text = "$\(amount?.rounded(toPlaces: 2) ?? 0)"
            label.font = .systemFont(ofSize: 34, weight: .heavy)
            label.textColor = .white
        }
        return label
    }
    
    
    //MARK: - Progress View Layer
    func configBackgroundLayer() -> CAShapeLayer {
            let bgLayer = CAShapeLayer()
            bgLayer.path = configProgressPath()
            bgLayer.fillColor = nil
            bgLayer.lineCap = .round
            bgLayer.lineWidth = 8
            bgLayer.strokeColor = UIColor.gray.cgColor
            return bgLayer
        }
    
    func configProgressLayer() -> CAShapeLayer {
        let progressLayer = CAShapeLayer()
        progressLayer.path = configProgressPath()
        progressLayer.fillColor = nil
        progressLayer.lineCap = .round
        progressLayer.lineWidth = 14
        progressLayer.strokeColor = UIColor.white.cgColor
        progressLayer.strokeEnd = 0
        
        progressLayer.shadowColor = UIColor.white.cgColor
        progressLayer.shadowOffset = CGSize(width: 0, height: 0)
        progressLayer.shadowOpacity = 0.4
        progressLayer.shadowRadius = 5
        return progressLayer
    }
    
    func configProgressPath() -> CGPath {
            UIBezierPath(arcCenter: CGPoint(x: container.bounds.midX, y: container.bounds.midY),
                            radius: 120,
                            startAngle: CGFloat.pi ,
                            endAngle: 2 * CGFloat.pi ,
                            clockwise: true
               ).cgPath
        }
    
    //MARK: - Progress View Animation
    func startAnimation(progress: Double, total: Double) {
        
        let total = CGFloat(total)
        let progress = CGFloat(progress) / total
        
        
        progressLayer?.strokeEnd = progress
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        
        animation.fromValue = 0
        animation.toValue = progress
        animation.duration = 2
        
        progressLayer?.add(animation, forKey: "strokeEndAnimation")
    }
    
}

//MARK: - Add Spends ViewController
extension AddSpendsViewController {
    func createStackView(axis: NSLayoutConstraint.Axis) -> UIStackView {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = axis
        sv.spacing = 10
        
        return sv
    }
    
    func createTextField(placeholder: String) -> UITextField {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = .clear
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 20
        tf.layer.borderColor = GrayColors.gray70.OWColor.cgColor
        tf.placeholder = placeholder
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        tf.leftView = paddingView
        tf.leftViewMode = .always
            
        return tf
    }
    
    func createButton(selector: Selector) -> UIButton {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Add spends", for: .normal)
        btn.tintColor = .systemGray
        btn.layer.cornerRadius = 15
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.darkGray.cgColor
        btn.addTarget(self, action: selector, for: .touchUpInside)
        return btn
    }
}

//MARK: - Add New Category ViewController
extension AddNewCategoryViewController {
    func createStackView(axis: NSLayoutConstraint.Axis) -> UIStackView {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = axis
        sv.spacing = 20
        
        return sv
    }
    
    func createTextField(placeholder: String) -> UITextField {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = .clear
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 20
        tf.layer.borderColor = GrayColors.gray70.OWColor.cgColor
        tf.placeholder = placeholder
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        tf.leftView = paddingView
        tf.leftViewMode = .always
            
        return tf
    }
    
   
    
    func createButton(selector: Selector) -> UIButton {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Add new category", for: .normal)
        btn.tintColor = .systemGray
        btn.layer.cornerRadius = 15
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.darkGray.cgColor
        btn.addTarget(self, action: selector, for: .touchUpInside)
        return btn
    }
}

//MARK: - Category Cell
extension CategorieCell {
     //MARK: Progress Layer
    func configBackgroundLayer() -> CAShapeLayer {
        let bgLayer = CAShapeLayer()
        bgLayer.path = configProgressPath()
        bgLayer.fillColor = nil
        bgLayer.lineCap = .round
        bgLayer.lineWidth = 4
        bgLayer.strokeColor = UIColor.gray.cgColor
        return bgLayer
    }
    
    func configProgressLayer(color: UIColor) -> CAShapeLayer {
        let progressLayer = CAShapeLayer()
        progressLayer.path = configProgressPath()
        
        progressLayer.fillColor = nil
        progressLayer.lineCap = .round
        progressLayer.lineWidth = 4
        progressLayer.strokeColor = color.cgColor

        return progressLayer
    }
    
  
    func configProgressPath() -> CGPath {
        let path = UIBezierPath()
            path.move(to: CGPoint(x: container.bounds.minX, y: container.bounds.midY))
            path.addLine(to: CGPoint(x: container.bounds.maxX, y: container.bounds.midY))
            return path.cgPath
    }
    
    func startAnimation(currentSum: Double, total: Double) {
          let progress = currentSum / total
          progressLayer?.strokeEnd = 0
          let animation = CABasicAnimation(keyPath: "strokeEnd")
          animation.toValue = progress
          animation.duration = 1.0
          animation.fillMode = .forwards
          animation.isRemovedOnCompletion = false
          progressLayer?.add(animation, forKey: "progressAnim")
      }
}

extension ExpenseCell {
    func createStackView(axis: NSLayoutConstraint.Axis) -> UIStackView {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = axis
        sv.spacing = 0
        sv.distribution = .equalSpacing
        return sv
    }
}

extension IncomeCell {
    func createStackView(axis: NSLayoutConstraint.Axis) -> UIStackView {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = axis
        sv.spacing = 0
        sv.distribution = .equalSpacing
        return sv
    }
}

extension IncomeViewController {
    func createButton(selector: Selector) -> UIButton {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "addIcon"), for: .normal)
        btn.addTarget(self, action: selector, for: .touchUpInside)
        btn.tintColor = .systemGray
        btn.layer.cornerRadius = 15
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.darkGray.cgColor
        
        btn.setTitle("Add new income", for: .normal)
            
            NSLayoutConstraint.activate([
                btn.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 11),
            ])
        
        return btn
        }
    }

extension AddNewIncomeViewController {
    func createStackView(axis: NSLayoutConstraint.Axis) -> UIStackView {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = axis
        sv.spacing = 20
        
        return sv
    }
    
    func createTextField(placeholder: String) -> UITextField {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = .clear
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 20
        tf.layer.borderColor = GrayColors.gray70.OWColor.cgColor
        tf.placeholder = placeholder
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        tf.leftView = paddingView
        tf.leftViewMode = .always
            
        return tf
    }
    
   
    
    func createButton(selector: Selector) -> UIButton {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Add new category", for: .normal)
        btn.tintColor = .systemGray
        btn.layer.cornerRadius = 15
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.darkGray.cgColor
        btn.addTarget(self, action: selector, for: .touchUpInside)
        return btn
    }
    

}
