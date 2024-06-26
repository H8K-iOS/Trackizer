import UIKit
import FirebaseFirestore
import FirebaseAuth

protocol AddNewCategoryViewControllerDelegate: AnyObject {
    func didAddNewCategory()
}

protocol AddNewSpendViewControllerDelegate: AnyObject {
    func didAddNewSpending()
}

final class BudgetViewController: UIViewController {
    //MARK: - Constants
    private let tableView = UITableView()
    private let viewModel: BudgetViewModel
    private let vStack = UIStackView()
    private var totalBudget: Double? = 0
    private var refreshControl = UIRefreshControl()
    let container = UIView()
    private let noCategoryContainer = UIView()
    private let imageView = UIImageView()
    
    
    //MARK: - Variables
    private lazy var addCategoryButton = createButton(type: .category, selector: #selector(addCategoryButtonTapped))
    private lazy var budgetLabel = createLabel(of: categorySum,
                                               type: .budget)
    private lazy var budgetDescriptionLabel = createLabel(of: totalBudget,
                                                          type: .description)
    
    private lazy var userButton = createRoundButton(imageName: "person.fill", selector: #selector(userButtonTapped))
    private var categorySum: Double? = 0
    
    var backgroundLayer: CAShapeLayer?
    var progressLayer: CAShapeLayer?
    
    //MARK: - Lifecycle
    init(viewModel: BudgetViewModel = BudgetViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        
        setBackground()
        setupRoundView()
        setupUI()
        setupLayots()
        fetchCategories()
        setupRoundViewProgressLayers()
        checkData()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateCurrencySymbol), name: .currencyDidChange, object: nil)
                
        updateCurrencySymbol()
    }
    
    //MARK: ViewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        backgroundLayer?.path = configProgressPath()
        progressLayer?.path = configProgressPath()
        
        updateRoundView()
    }
    
    //MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        refreshData()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    @objc private func addCategoryButtonTapped() {
        let addNewCategoryVC = AddNewCategoryViewController()
        addNewCategoryVC.delegate = self
        present(addNewCategoryVC, animated: true)
    }
    
    @objc private func userButtonTapped() {
        let vc = UserViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.isModalInPresentation = true
        if #available(iOS 15.0, *) {
            if let sheet = nav.sheetPresentationController {
                if #available(iOS 16.0, *) {
                    sheet.preferredCornerRadius = 40
                    sheet.detents = [.custom(resolver: { context in
                        0.2 * context.maximumDetentValue
                    }), .large()]
                } else {
                    navigationController?.present(nav, animated: true)
                }
            }
        }
        navigationController?.present(nav, animated: true)
    }
    
    func checkData() {
        if viewModel.categories.isEmpty {
            imageView.isHidden = false
        } else {
            imageView.isHidden = true
        }
    }
    
    @objc private func check() {
        guard let categorySum = self.categorySum,
              let total = self.totalBudget else { return }
        
        if categorySum > total {
            budgetLabel.textColor = .red
            progressLayer?.strokeColor = UIColor.red.cgColor
        } else {
            budgetLabel.textColor = .white
            progressLayer?.strokeColor = UIColor.white.cgColor
        }
    }
    
    @objc private func refreshData() {
        fetchCategories()
        updateRoundView()
        checkData()
        updateUI()
    }
    
    private func updateRoundView() {
        self.viewModel.fetchCategorySpending { [weak self] categorySpending, error in
            if categorySpending != nil {
                
                self?.startAnimation(progress: self?.categorySum ?? 0, total: self?.totalBudget ?? 0.0 )
                self?.categorySum = self?.viewModel.calculateTotalSpending()
                self?.totalBudget = self?.viewModel.calculateTotalBudget()
                self?.updateUI()
            } else if let error {
                AlertManager.ShowFetchingUserError(on: self ?? UIViewController(), with: error)
            }
        }
    }
    
    @objc private func updateCurrencySymbol() {
            let currencySymbol = CurrencyManager.shared.currentSymbol.rawValue
            
            if let totalBudget = totalBudget {
                budgetDescriptionLabel.text = "of \(currencySymbol) \(totalBudget) budget"
            }
            
            if let categorySum = categorySum {
                budgetLabel.text = "\(currencySymbol) \(categorySum)"
            }
        }
    
    //MARK: - Networking
    private func fetchCategories() {
        viewModel.fetchCategories { [weak self]categories, error in
            if let categories {
                self?.viewModel.categories = categories
                self?.tableView.reloadData()
            } else if let error = error {
                print(error)
            }
        }
    }
}
//MARK: - Extensions
    //MARK: - VC UI
private extension BudgetViewController {
    func setupUI() {
        
        self.view.addSubview(addCategoryButton)
        addCategoryButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(CategorieCell.self, forCellReuseIdentifier: CategorieCell.identifier)
        
        tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
        self.view.addSubview(noCategoryContainer)
        noCategoryContainer.translatesAutoresizingMaskIntoConstraints = false
        
        noCategoryContainer.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "opsImage.png")
        imageView.contentMode = .scaleAspectFill
    
        self.view.addSubview(userButton)
        userButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupLayots() {
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            tableView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            tableView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 2.65),
            tableView.topAnchor.constraint(equalTo: container.bottomAnchor, constant: 16),
            
            userButton.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            userButton.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            
            
            addCategoryButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 16),
            addCategoryButton.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            addCategoryButton.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            
            imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.widthAnchor.constraint(equalToConstant: 200),
        ])
    }
    
}

//MARK: - Round view
extension BudgetViewController  {
    //MARK: Round View Container setup
    func setupRoundView() {
        
        self.view.addSubview(container)
        container.addSubview(vStack)
        vStack.addArrangedSubview(budgetLabel)
        vStack.addArrangedSubview(budgetDescriptionLabel)
    
        container.translatesAutoresizingMaskIntoConstraints = false
        budgetLabel.translatesAutoresizingMaskIntoConstraints = false
        budgetDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        vStack.translatesAutoresizingMaskIntoConstraints = false
        
        container.backgroundColor = .clear
        
        vStack.axis = .vertical
        vStack.spacing = 5
        vStack.alignment = .center
        
        NSLayoutConstraint.activate([
            
            container.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            container.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -Constants.screenHeight/4),
            container.widthAnchor.constraint(equalToConstant: 210),
            container.heightAnchor.constraint(equalToConstant: 90),
            
            budgetLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 4),
            budgetLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor),
        ])
        
    }

    func updateUI() {
        tableView.reloadData()
        refreshControl.endRefreshing()
        checkData()
        updateCurrencySymbol()
        check()
        
    }
    
    //MARK: Progress View Setup
    func setupRoundViewProgressLayers() {
          let backgroundLayer = configBackgroundLayer()
          container.layer.addSublayer(backgroundLayer)
          self.backgroundLayer = backgroundLayer
          
          let progressLayer = configProgressLayer()
          container.layer.insertSublayer(progressLayer,
                                         above: backgroundLayer)
          self.progressLayer = progressLayer
      }
}

//MARK: - Table View
extension BudgetViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: false)
        let budget = self.viewModel.categories[indexPath.row]
        let vm = AddSpendsViewModel(budget)
        let vc = AddSpendsViewController(vm)
        vc.delegate = self
        self.present(vc, animated: true)
    }
}

extension BudgetViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.categories.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategorieCell.identifier,
                                                 for: indexPath) as? CategorieCell else { return UITableViewCell() }
        
        cell.selectionStyle = .none
        cell.selectedBackgroundView = .none
        
        let category = self.viewModel.categories[indexPath.row]
        cell.configCell(with: category)
        
        return cell
    }
}

//MARK: - Update UI Protocols
extension BudgetViewController: AddNewCategoryViewControllerDelegate {
    func didAddNewCategory() {
        DispatchQueue.main.async { [weak self] in
            self?.refreshData()
            self?.tableView.reloadData()
        }
    }
}

extension BudgetViewController: AddNewSpendViewControllerDelegate {
    func didAddNewSpending() {
        DispatchQueue.main.async { [weak self] in
            self?.refreshData()
            self?.tableView.reloadData()
        }
    }
}
