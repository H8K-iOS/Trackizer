import UIKit
import FirebaseFirestore
import FirebaseAuth

protocol AddNewCategoryViewControllerDelegate: AnyObject {
    func didAddNewCategory(_ category: BudgetModel)
}

final class BudgetViewController: UIViewController {
    //MARK: - Constants
    private let tableView = UITableView()
    private let viewModel: BudgetViewModel
    private let vStack = UIStackView()
    private var totalBudget: Double? = 0
    private var refreshControl = UIRefreshControl()
    let container = UIView()
    private let buttonHStack: UIStackView = {
        let hs = UIStackView()
        hs.axis = .horizontal
        hs.spacing = 10
        return hs
    }()
    
    private let noCategoryContainer = UIView()
    private let imageView = UIImageView()
    
    
    //MARK: - Variables
    private lazy var addCategoryButton = createButton(type: .category, selector: #selector(addCategoryButtonTapped))
    private lazy var budgetLabel = createLabel(of: categorySum,
                                               type: .budget)
    private lazy var budgetDescriptionLabel = createLabel(of: totalBudget,
                                                          type: .description)
    
    private lazy var updateButton = createRoundButton(imageName: "arrow.triangle.2.circlepath", selector: #selector(updateButtonTapped))
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
        //TODO: -
     
        setBudget()
        setBackground()
        setupRoundView()
        setupUI()
        setupLayots()
        fetchCategories()
        setupRoundViewProgressLayers()
        checkData()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    //MARK: ViewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        backgroundLayer?.path = configProgressPath()
        progressLayer?.path = configProgressPath()
        
        refreshData()
    }
    
    //MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        updateRoundView()
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
        present(UserViewController(), animated: true)
    }
    
    @objc private func updateButtonTapped() {
        refreshData()
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
        self.view.addSubview(updateButton)
        updateButton.translatesAutoresizingMaskIntoConstraints = false
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
        
        self.view.addSubview(buttonHStack)
        buttonHStack.translatesAutoresizingMaskIntoConstraints = false
        
        buttonHStack.addArrangedSubview(userButton)
        buttonHStack.addArrangedSubview(updateButton)
        
    }
    
    func setupLayots() {
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            tableView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            tableView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 2.65),
            tableView.topAnchor.constraint(equalTo: container.bottomAnchor, constant: 16),
            
            buttonHStack.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            buttonHStack.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -10),
            
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
            container.heightAnchor.constraint(equalToConstant: 120),
            
            budgetLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 4),
            budgetLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor),
        ])
        
    }

    func updateUI() {
        tableView.reloadData()
        refreshControl.endRefreshing()
        checkData()
        budgetLabel.text = "$\(categorySum?.rounded(toPlaces: 2) ?? 0)"
        budgetDescriptionLabel.text = "of $\(totalBudget?.rounded(toPlaces: 2) ?? 0) budget"
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
           
           let onUpdate: () -> Void = { [weak self] in
               self?.didAddNewSpending()
           }
           
        let vc = AddSpendsViewController(vm, onUpdate: onUpdate)
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

//MARK: - FireBase
extension BudgetViewController {
    func setBudget() {
        self.viewModel.onBudgetUpdate = { [weak self] in
            DispatchQueue.main.async {
                
                self?.tableView.reloadData()
                self?.refreshControl.endRefreshing()
            }
        }
    }
}

extension BudgetViewController: AddNewCategoryViewControllerDelegate {
    func didAddNewCategory(_ category: BudgetModel) {
        viewModel.categories.append(category)
        tableView.reloadData()
        updateRoundView()
        checkData()
    }
}

extension BudgetViewController {
    func didAddNewSpending() {
        fetchCategories()
        updateRoundView()
        checkData()
    }
}
