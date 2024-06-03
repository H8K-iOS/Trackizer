import UIKit
import DropDown

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
    private let viewModel: AddNewCategoryViewModel
    private let button = UIButton()
    private let categoryNameLabel = UILabel()
    
    private let categoryPickerView = UIView()
    private let categoryPickerLabel = UILabel()
    private let categoryPickerCategoryNameLabel = UILabel()
    private let categoryPickerPickButton = UIButton()
    private let dropDownMenu = DropDown()
    
    
    
    private lazy var totalBudgetTextField = createTextField(placeholder: "Budget for category")
    private lazy var textFieldVStack = createStackView(axis: .vertical)
    
    //MARK: Variables
    private lazy var continueButton = createButton(selector: #selector(continueButtonTapped))
    
    //MARK: lifecycle
    init(_ viewModel: AddNewCategoryViewModel = AddNewCategoryViewModel()) {
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
        setCategoryPicker()
        
        setupDropDownMenu()
    }
    //MARK: Methods
    
    @objc func continueButtonTapped() {
            guard let categoryText = categoryPickerCategoryNameLabel.text,
                  let totalBudget = totalBudgetTextField.text,
                  let value = Double(totalBudget) else {
                AlertManager.showAddCategoryErrorAlert(on: self)
                return
            }
    
        viewModel.addCategory(categoryName: categoryText, categoryBudget: value) { [weak self] error in
            if let error {
                AlertManager.showAddCategoryErrorAlert(on: self ?? UIViewController())
            } else {
                self?.dismiss(animated: true, completion: nil)
            }
        }
    }
 

    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @objc private func closeButtonTapped() {
        self.dismiss(animated: true)
    }
    
    @objc private func pickButtonTapped() {
        dropDownMenu.show()
    }
}

//MARK: - Extensions
private extension AddNewCategoryViewController {
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
        self.view.addSubview(button)
        self.view.addSubview(textFieldVStack)
        self.view.addSubview(continueButton)
        self.view.addSubview(categoryPickerLabel)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        textFieldVStack.addArrangedSubview(categoryPickerView)
        textFieldVStack.addArrangedSubview(totalBudgetTextField)

        categoryNameLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryPickerLabel.translatesAutoresizingMaskIntoConstraints = false
        totalBudgetTextField.translatesAutoresizingMaskIntoConstraints = false
        textFieldVStack.translatesAutoresizingMaskIntoConstraints = false
        
        categoryNameLabel.textColor = .white
        categoryNameLabel.text = "New Category"
        categoryNameLabel.font = .systemFont(ofSize: 22, weight: .heavy)
        
        categoryPickerLabel.textColor = .white
        categoryPickerLabel.text = "Your category"
        categoryPickerLabel.font = .systemFont(ofSize: 16, weight: .medium)
        
        
        button.setTitle("Close", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .light)
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: blurContaienr.topAnchor, constant: 16),
            button.leftAnchor.constraint(equalTo: blurContaienr.leftAnchor, constant: 16),
            
            categoryNameLabel.topAnchor.constraint(equalTo: blurContaienr.topAnchor, constant: 16),
            categoryNameLabel.centerXAnchor.constraint(equalTo: blurContaienr.centerXAnchor),
            
            textFieldVStack.leftAnchor.constraint(equalTo: blurContaienr.leftAnchor, constant: 8),
            textFieldVStack.rightAnchor.constraint(equalTo: blurContaienr.rightAnchor, constant: -8),
            textFieldVStack.centerYAnchor.constraint(equalTo: blurContaienr.centerYAnchor),
            
            
            categoryPickerView.heightAnchor.constraint(equalToConstant: Constants.screenHeight / 15),
            totalBudgetTextField.heightAnchor.constraint(equalToConstant: Constants.screenHeight / 15),
            
            categoryPickerLabel.bottomAnchor.constraint(equalTo: categoryPickerView.topAnchor, constant: -12),
            categoryPickerLabel.leftAnchor.constraint(equalTo: blurContaienr.leftAnchor, constant: 16),
            
            
            continueButton.bottomAnchor.constraint(equalTo: blurContaienr.bottomAnchor, constant: -16),
            continueButton.leftAnchor.constraint(equalTo: blurContaienr.leftAnchor, constant: 16),
            continueButton.rightAnchor.constraint(equalTo: blurContaienr.rightAnchor, constant: -16),
            
            continueButton.heightAnchor.constraint(equalToConstant: Constants.screenHeight/15)
            
        ])
        
        
        
      

    }
}

extension AddNewCategoryViewController {
    func setupDropDownMenu() {
        dropDownMenu.anchorView = categoryPickerView
        dropDownMenu.dataSource = viewModel.categories
        dropDownMenu.bottomOffset = CGPoint(x: 0, y: (dropDownMenu.anchorView?.plainView.bounds.height)!)
        dropDownMenu.topOffset = CGPoint(x: 0, y: -(dropDownMenu.anchorView?.plainView.bounds.height)!)
        dropDownMenu.direction = .bottom
        
        dropDownMenu.selectionAction = { (index: Int, item: String) in
            self.categoryPickerCategoryNameLabel.text = self.viewModel.categories[index]
            self.categoryPickerCategoryNameLabel.textColor = .white
        }
    }
    
    func setCategoryPicker() {
        
        categoryPickerView.addSubview(categoryPickerCategoryNameLabel)
        categoryPickerView.addSubview(categoryPickerPickButton)
        
        
        categoryPickerCategoryNameLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryPickerPickButton.translatesAutoresizingMaskIntoConstraints = false
        categoryPickerView.translatesAutoresizingMaskIntoConstraints = false
        
        
        categoryPickerView.backgroundColor = .clear
        categoryPickerView.layer.borderWidth = 1
        categoryPickerView.layer.cornerRadius = 20
        categoryPickerView.layer.borderColor = GrayColors.gray70.OWColor.cgColor
        
        
        categoryPickerCategoryNameLabel.textColor = .gray
        categoryPickerCategoryNameLabel.text = "Select category"
        categoryPickerCategoryNameLabel.font = .systemFont(ofSize: 14, weight: .medium)
        
        categoryPickerPickButton.setImage(UIImage(systemName: "arrowtriangle.down"), for: .normal)
        categoryPickerPickButton.addTarget(self, action: #selector(pickButtonTapped), for: .touchUpInside)
        categoryPickerPickButton.tintColor = .white
        
        NSLayoutConstraint.activate([
        
            categoryPickerCategoryNameLabel.centerYAnchor.constraint(equalTo: categoryPickerView.centerYAnchor),
            categoryPickerCategoryNameLabel.leftAnchor.constraint(equalTo: categoryPickerView.leftAnchor, constant: 16),
            
            
            categoryPickerPickButton.rightAnchor.constraint(equalTo: categoryPickerView.rightAnchor, constant: -16),
            categoryPickerPickButton.topAnchor.constraint(equalTo: categoryPickerView.topAnchor, constant: 16),
            categoryPickerPickButton.bottomAnchor.constraint(equalTo: categoryPickerView.bottomAnchor, constant: -16)
        ])
    }
}
