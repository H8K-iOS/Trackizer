import UIKit

final class AddSpendsViewController: UIViewController {
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
    private let viewModel: AddSpendsViewModel
    private let button = UIButton()
    private let categoryNameLabel = UILabel()
    
    
    private lazy var spendNameTextField = createTextField(placeholder: "Name of the expenditure")
    private lazy var valueTextField = createTextField(placeholder: "Amount spent")
    private lazy var textFieldVStack = createStackView(axis: .vertical)
    
    //MARK: Variables
    private lazy var continueButton = createButton(selector: #selector(continueButtonTapped))
    
    //MARK: lifecycle
    init(_ viewModel: AddSpendsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overFullScreen
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
        displayCategoryInfo()
    }
    //MARK: Methods
    
    @objc func continueButtonTapped() {
        guard let spendsName = spendNameTextField.text,
                  let valueText = valueTextField.text,
                  let value = Double(valueText) else {
                AlertManager.showAddSpendsErrorAlert(on: self)
                
                return
            }
            
            let categoryName = viewModel.categoryName
        viewModel.updateCategorySpending(categoryName: categoryName, spendsName: spendsName, amount: value) { [weak self] error in
                if let error = error {
                    print("Failed to update category spending: ")
                    
                } else {
                    self?.dismiss(animated: true, completion: nil)
                }
            }
        
        }
    
    @objc private func closeButtonTapped() {
        self.dismiss(animated: true)
    }
}

//MARK: - Extensions
private extension AddSpendsViewController {
    func setupBackground() {
        self.view.addSubview(blurContaienr)
        blurContaienr.effect = blurEffect
        
        NSLayoutConstraint.activate([
            
            blurContaienr.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            blurContaienr.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            
            blurContaienr.widthAnchor.constraint(equalToConstant: Constants.screenHeight/2.7),
            blurContaienr.heightAnchor.constraint(equalToConstant: Constants.screenHeight/2),
        ])
    }
    
    
    func setupUI() {
        self.view.addSubview(categoryNameLabel)
        self.view.addSubview(textFieldVStack)
        self.view.addSubview(continueButton)
        self.view.addSubview(button)
        textFieldVStack.addArrangedSubview(spendNameTextField)
        textFieldVStack.addArrangedSubview(valueTextField)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle("Close", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .light)
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        
        categoryNameLabel.translatesAutoresizingMaskIntoConstraints = false
        spendNameTextField.translatesAutoresizingMaskIntoConstraints = false
        valueTextField.translatesAutoresizingMaskIntoConstraints = false
        textFieldVStack.translatesAutoresizingMaskIntoConstraints = false
        
        categoryNameLabel.textColor = .white
        categoryNameLabel.text = "category"
        categoryNameLabel.font = .systemFont(ofSize: 24, weight: .heavy)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: blurContaienr.topAnchor, constant: 16),
            button.leftAnchor.constraint(equalTo: blurContaienr.leftAnchor, constant: 16),
            
            categoryNameLabel.topAnchor.constraint(equalTo: blurContaienr.topAnchor, constant: 16),
            categoryNameLabel.centerXAnchor.constraint(equalTo: blurContaienr.centerXAnchor),
            
            textFieldVStack.leftAnchor.constraint(equalTo: blurContaienr.leftAnchor, constant: 8),
            textFieldVStack.rightAnchor.constraint(equalTo: blurContaienr.rightAnchor, constant: -8),
            textFieldVStack.centerYAnchor.constraint(equalTo: blurContaienr.centerYAnchor),
        
            spendNameTextField.heightAnchor.constraint(equalToConstant: Constants.screenHeight / 15),
            valueTextField.heightAnchor.constraint(equalToConstant: Constants.screenHeight / 15),
           
            
            continueButton.bottomAnchor.constraint(equalTo: blurContaienr.bottomAnchor, constant: -16),
            continueButton.leftAnchor.constraint(equalTo: blurContaienr.leftAnchor, constant: 16),
            continueButton.rightAnchor.constraint(equalTo: blurContaienr.rightAnchor, constant: -16),
            
            continueButton.heightAnchor.constraint(equalToConstant: Constants.screenHeight/15)

        ])
    }
    
    func displayCategoryInfo() {
        self.categoryNameLabel.text = self.viewModel.categoryName
    }
}
