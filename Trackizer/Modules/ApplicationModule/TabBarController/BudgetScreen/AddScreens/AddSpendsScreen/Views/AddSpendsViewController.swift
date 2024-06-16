import UIKit

enum State {
    case add
    case edit
}

final class AddSpendsViewController: UIViewController {
    // MARK: Constants
    private var state = State.add
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
    
    private let viewModel: AddSpendsViewModel
    private let closeButton = UIButton()
    private let editButton = UIButton()
    private let deleteButton = UIButton()
    private let buttonHStack = UIStackView()
    private let categoryNameLabel = UILabel()
    private let datePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = .dateAndTime
        dp.locale = .current
        dp.preferredDatePickerStyle = .compact
        dp.tintColor = .white
        return dp
    }()
    private let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))

    // MARK: Variables
    private lazy var spendNameTextField = createTextField(placeholder: "Name of the expenditure")
    private lazy var valueTextField = createTextField(placeholder: "Amount spent")
    private lazy var totalBudgetTextField = createTextField(placeholder: "Category budget amount")
    private lazy var textFieldVStack = createStackView(axis: .vertical)
    private lazy var continueButton = createButton(selector: #selector(continueButtonTapped))

    // MARK: Lifecycle
    init(_ viewModel: AddSpendsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        setupBackground()
        setupUI()
        displayCategoryInfo()
        
        // Add tap gesture recognizer to hide keyboard
        view.addGestureRecognizer(tapGesture)
        
        // Set text field delegates
        spendNameTextField.delegate = self
        valueTextField.delegate = self
        totalBudgetTextField.delegate = self
    }

    // MARK: Methods
    @objc func continueButtonTapped() {
        switch state {
        case .add:
            addNewSpends()
        case .edit:
            updateBudget()
        }
    }

    @objc private func deleteButtonTapped() {
        let alertController = UIAlertController(title: "Delete Category", message: "Are you sure you want to delete this category?", preferredStyle: .alert)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
            self.confirmDelete()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }

    private func confirmDelete() {
        let categoryName = viewModel.categoryName
        viewModel.deleteCategory(categoryName: categoryName) { error in
            if let error {
                print("Error deleting category: \(error.localizedDescription)")
            } else {
                DispatchQueue.main.async {
                    self.delegate?.didAddNewSpending()
                    self.dismiss(animated: true)
                }
            }
        }
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc private func closeButtonTapped() {
        self.dismiss(animated: true)
    }

    @objc private func editButtonTapped() {
        self.state = (self.state == .add) ? .edit : .add
        
        switch state {
        case .add:
            self.categoryNameLabel.text = viewModel.categoryName
            self.editButton.setImage(UIImage(systemName: "gear"), for: .normal)
            self.totalBudgetTextField.isHidden = true
            self.textFieldVStack.isHidden = false
            self.datePicker.isHidden = false
            self.deleteButton.isHidden = true
            self.continueButton.setTitle("Add spends", for: .normal)
        case .edit:
            self.categoryNameLabel.text = "Edit"
            self.editButton.setImage(UIImage(systemName: "arrowshape.turn.up.backward.fill"), for: .normal)
            self.textFieldVStack.isHidden = true
            self.datePicker.isHidden = true
            self.deleteButton.isHidden = false
            self.totalBudgetTextField.isHidden = false
            self.continueButton.setTitle("Edit budget", for: .normal)
        }
    }

    private func addNewSpends() {
        guard let spendsName = spendNameTextField.text,
              let valueText = valueTextField.text,
              let value = Double(valueText) else {
            AlertManager.showAddSpendsErrorAlert(on: self)
            return
        }
        
        let categoryName = viewModel.categoryName
        let selectedDate = datePicker.date
        
        viewModel.updateCategorySpending(categoryName: categoryName, spendsName: spendsName, date: selectedDate, amount: value) { [weak self] error in
            if error != nil {
                print("Failed to update category spending: ")
            } else {
                self?.delegate?.didAddNewSpending()
                self?.dismiss(animated: true, completion: nil)
            }
        }
    }

    private func updateBudget() {
        guard let budget = totalBudgetTextField.text,
              let value = Double(budget) else {
            AlertManager.showBudgetEditErrorAlert(on: self)
            return
        }
        
        let categoryName = viewModel.categoryName
        
        viewModel.updateCategoryBudget(categoryName: categoryName, budget: value) { [weak self] error in
            if error != nil {
                print("Failed to update category budget: ")
            } else {
                self?.delegate?.didAddNewSpending()
                self?.dismiss(animated: true, completion: nil)
            }
        }
    }
}

// MARK: - Extensions
private extension AddSpendsViewController {
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
        self.view.addSubview(categoryNameLabel)
        self.view.addSubview(textFieldVStack)
        self.view.addSubview(continueButton)
        self.view.addSubview(closeButton)
        self.view.addSubview(datePicker)
        self.view.addSubview(editButton)
        self.view.addSubview(deleteButton)
        self.view.addSubview(totalBudgetTextField)
        
        textFieldVStack.addArrangedSubview(spendNameTextField)
        textFieldVStack.addArrangedSubview(valueTextField)
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        categoryNameLabel.translatesAutoresizingMaskIntoConstraints = false
        textFieldVStack.translatesAutoresizingMaskIntoConstraints = false
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        editButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        totalBudgetTextField.translatesAutoresizingMaskIntoConstraints = false
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        
        closeButton.setTitle("Close", for: .normal)
        closeButton.setTitleColor(.gray, for: .normal)
        closeButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .light)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        
        categoryNameLabel.textColor = .white
        categoryNameLabel.text = "Category"
        categoryNameLabel.font = .systemFont(ofSize: 24, weight: .heavy)
        
        editButton.backgroundColor = .clear
        editButton.tintColor = .gray
        editButton.setImage(UIImage(systemName: "gear"), for: .normal)
        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        
        deleteButton.backgroundColor = .clear
        deleteButton.tintColor = .gray
        deleteButton.isHidden = true
        deleteButton.setImage(UIImage(systemName: "trash"), for: .normal)
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        
        totalBudgetTextField.isHidden = true
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: blurContaienr.topAnchor, constant: 16),
            closeButton.leftAnchor.constraint(equalTo: blurContaienr.leftAnchor, constant: 16),
            
            editButton.topAnchor.constraint(equalTo: blurContaienr.topAnchor, constant: 16),
            editButton.rightAnchor.constraint(equalTo: blurContaienr.rightAnchor, constant: -16),
            
            deleteButton.topAnchor.constraint(equalTo: blurContaienr.topAnchor, constant: 16),
            deleteButton.rightAnchor.constraint(equalTo: editButton.rightAnchor, constant: -24),
            
            categoryNameLabel.topAnchor.constraint(equalTo: blurContaienr.topAnchor, constant: 16),
            categoryNameLabel.centerXAnchor.constraint(equalTo: blurContaienr.centerXAnchor),
            
            textFieldVStack.leftAnchor.constraint(equalTo: blurContaienr.leftAnchor, constant: 8),
            textFieldVStack.rightAnchor.constraint(equalTo: blurContaienr.rightAnchor, constant: -8),
            textFieldVStack.centerYAnchor.constraint(equalTo: blurContaienr.centerYAnchor),
            
            totalBudgetTextField.leftAnchor.constraint(equalTo: blurContaienr.leftAnchor, constant: 8),
            totalBudgetTextField.rightAnchor.constraint(equalTo: blurContaienr.rightAnchor, constant: -8),
            totalBudgetTextField.centerYAnchor.constraint(equalTo: blurContaienr.centerYAnchor),
            totalBudgetTextField.heightAnchor.constraint(equalToConstant: Constants.screenHeight / 15),
            
            datePicker.topAnchor.constraint(equalTo: textFieldVStack.bottomAnchor, constant: 16),
            datePicker.centerXAnchor.constraint(equalTo: blurContaienr.centerXAnchor),
        
            spendNameTextField.heightAnchor.constraint(equalToConstant: Constants.screenHeight / 15),
            valueTextField.heightAnchor.constraint(equalToConstant: Constants.screenHeight / 15),
            
            continueButton.bottomAnchor.constraint(equalTo: blurContaienr.bottomAnchor, constant: -16),
            continueButton.leftAnchor.constraint(equalTo: blurContaienr.leftAnchor, constant: 16),
            continueButton.rightAnchor.constraint(equalTo: blurContaienr.rightAnchor, constant: -16),
            continueButton.heightAnchor.constraint(equalToConstant: Constants.screenHeight / 15),
        ])
    }

    func displayCategoryInfo() {
        self.categoryNameLabel.text = self.viewModel.categoryName
    }
}

// MARK: - UITextFieldDelegate
extension AddSpendsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
