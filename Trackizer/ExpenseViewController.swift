import UIKit
import DGCharts


//test comm for charts
final class ExpenseViewController: UIViewController {
    //MARK: Constants
    private let tableView = UITableView()
    private var refreshControl = UIRefreshControl()
    private let searchBar = UISearchBar()
    
    private let pieChart = PieChartView()
    private let viewModel: ExpenseViewModel
    
    //MARK: Variables
    private lazy var updateButton = createRoundButton(imageName: "arrow.triangle.2.circlepath", selector: #selector(updateButtonTapped))
    
    //MARK: Lifecycle
    init(viewModel: ExpenseViewModel = ExpenseViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        fetchExpense()
        setBackground()
        setupUI()
        
        setLayouts()
        setExpense()
        
        tableView.dataSource = self
        tableView.delegate = self
        pieChart.delegate = self
        
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupPieChart()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshData()
        updatePieChart()
    }
    
    //MARK: Methods
    private func fetchExpense() {
        self.viewModel.fetchExpense { [weak self] expense, error in
            if let expense {
                self?.viewModel.expense = expense
                self?.updateUI()
                self?.updatePieChart()
            } else if let error {
                AlertManager.ShowFetchingUserError(on: self ?? UIViewController(), with: error)
            }
        }
    }
    
    @objc private func refreshData() {
        fetchExpense()
        self.tableView.reloadData()
    }
    
    func updateUI() {
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    @objc private func updateButtonTapped() {
        updateUI()
        refreshData()
    }
}

//MARK: - Extensions
private extension ExpenseViewController {
    func setupPieChart() {
    pieChart.frame = CGRect(x: 0, y: 0,
                            width: self.view.frame.size.width / 1.5,
                            height: self.view.frame.size.width / 1.5)
    pieChart.center = self.view.center
    pieChart.center.y = self.view.frame.size.height / 4.5
    pieChart.holeColor = UIColor.clear
    pieChart.transparentCircleColor = UIColor.clear
    self.view.addSubview(pieChart)
    
    updatePieChart()
}
    
    func updatePieChart() {
    var categoryTotals: [String: Double] = [:]
    
    for expense in viewModel.expense {
        
        if let currentTotal = categoryTotals[expense.categoryName] {
            categoryTotals[expense.categoryName] = currentTotal + expense.amount
        } else {
            
            categoryTotals[expense.categoryName] = expense.amount
        }
    }
    
    var entries = [PieChartDataEntry]()
    for (categoryName, totalAmount) in categoryTotals {
        let entry = PieChartDataEntry(value: totalAmount, label: categoryName)
        entries.append(entry)
    }
    
    let dataSet = PieChartDataSet(entries: entries, label: "Expenses")
    dataSet.colors = ChartColorTemplates.colorful()
    
    let data = PieChartData(dataSet: dataSet)
    pieChart.data = data
    pieChart.notifyDataSetChanged()
}
    
    func setupUI() {
        self.view.addSubview(tableView)
        tableView.addSubview(refreshControl)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(ExpenseCell.self, forCellReuseIdentifier: ExpenseCell.identifier)
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
        self.view.addSubview(updateButton)
        updateButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        self.view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.delegate = self
        searchBar.placeholder = "Search Category"
        searchBar.sizeToFit()
        searchBar.backgroundColor = .clear
        searchBar.backgroundImage = UIImage()
    }
    
    func setLayouts() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -Constants.screenHeight/10),
            searchBar.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            searchBar.rightAnchor.constraint(equalTo: updateButton.leftAnchor, constant: -4),
            
            updateButton.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            updateButton.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            tableView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
   
        ])
    }
}

extension ExpenseViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        let id = viewModel.expense[indexPath.row].expenseID
        
        let removedExpense = viewModel.expense.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
        viewModel.deleteExpense(expenseID: id) { [weak self] error in
            if let error = error {
                
                AlertManager.showDeleteExpenseErrorAlert(on: self ?? UIViewController(), with: error)
                
                
                self?.viewModel.expense.insert(removedExpense, at: indexPath.row)
                self?.tableView.insertRows(at: [indexPath], with: .automatic)
            } else {
                
                self?.updatePieChart()
            }
        }
    }
}

extension ExpenseViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(isSearchActive: viewModel.isSearchActive(searchText: searchBar.text))
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ExpenseCell.identifier, for: indexPath) as? ExpenseCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.selectedBackgroundView = .none
        
        let expenses = viewModel.isSearchActive(searchText: searchBar.text) ? viewModel.filtered : viewModel.expense
        let expense = expenses[indexPath.row]
        cell.configCell(with: expense)
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .delete
    }
    
}




extension ExpenseViewController: ChartViewDelegate {}


extension ExpenseViewController {
    func setExpense() {
        self.viewModel.onExpenseUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.refreshControl.endRefreshing()
            }
        }
    }
}

extension ExpenseViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel.updateSearchController(searchText: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        self.viewModel.updateSearchController(searchText: nil)
        searchBar.resignFirstResponder()
    }
}


