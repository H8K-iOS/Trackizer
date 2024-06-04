import UIKit
import FirebaseFirestore
import FirebaseAuth


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
    private lazy var userButtonSize = UIScreen.main.bounds.height / 20
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
     
        
        setBackground()
        setupRoundView()
        setupUI()
        setupLayots()
        setupRoundViewProgressLayers()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        setBudget()
        fetchCategories()
        updateRoundView()
        checkData()
    }
    //MARK: ViewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        backgroundLayer?.path = configProgressPath()
        progressLayer?.path = configProgressPath()
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
    
    //TODO: -
    
    
    
    @objc private func addCategoryButtonTapped() {
        
        present(AddNewCategoryViewController(), animated: true)
        
        
    }
    
    @objc private func userRightBarButtonTaped() {
       // present(UserViewController(), animated: true)
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
        } else {
            budgetLabel.textColor = .white
        }
    }
    
    @objc private func refreshData() {
        fetchCategories()
        updateRoundView()
        checkData()
    }
    
    private func updateRoundView() {
        self.viewModel.fetchCategorySpending { [weak self] categorySpending, error in
            if let categorySpending {
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
        self.view.addSubview(tableView)
        self.view.addSubview(addCategoryButton)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        addCategoryButton.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.addSubview(refreshControl)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(CategorieCell.self, forCellReuseIdentifier: CategorieCell.identifier)
        
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
        
        
        
        self.view.addSubview(noCategoryContainer)
        noCategoryContainer.translatesAutoresizingMaskIntoConstraints = false
        
        
        noCategoryContainer.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "opsImage.png")
        imageView.contentMode = .scaleAspectFill
    }
    
    func setupLayots() {
        NSLayoutConstraint.activate([

            tableView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            tableView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            tableView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 2.65),
            tableView.topAnchor.constraint(equalTo: container.bottomAnchor),
            
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
        let vc = AddSpendsViewController(vm)
        self.present(vc, animated: true)
    }
}

extension BudgetViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        print(viewModel.categories.count)
        
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
