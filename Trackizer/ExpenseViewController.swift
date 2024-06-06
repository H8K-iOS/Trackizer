import UIKit
import DGCharts


//test comm for charts
final class ExpenseViewController: UIViewController {
    //MARK: Constants
    private let tableView = UITableView()
    private var refreshControl = UIRefreshControl()
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
        
        tableView.dataSource = self
        tableView.delegate = self
        pieChart.delegate = self
        
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupPieChart()
    }
    //MARK: Methods
    
    private func fetchExpense() {
        self.viewModel.fetchExpense { [weak self] expense, error in
            if let expense {
                self?.viewModel.expense = expense
                self?.updateUI()
            } else if let error {
                AlertManager.ShowFetchingUserError(on: self ?? UIViewController(), with: error)
            }
        }
    }
    
    @objc private func refreshData() {
        fetchExpense()
    }
    
    func updateUI() {
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    @objc private func updateButtonTapped() {
        updateUI()
    }
}

//MARK: - Extensions
private extension ExpenseViewController {
    func setupPieChart() {
        
        pieChart.frame = CGRect(x: 0, y: 0,
                                width: self.view.frame.size.width/1.5,
                                height: self.view.frame.size.width/1.5)
        pieChart.center = self.view.center
       
            pieChart.center.x = self.view.center.x
        pieChart.center.y = self.view.frame.size.height / 4.5
        
        self.view.addSubview(pieChart)
        
        var entries = [BarChartDataEntry]()
        
        for x in 0..<7 {
            entries.append(BarChartDataEntry(x: Double(x),
                                             y: Double(x)))
        }
        
        let set = PieChartDataSet(entries: entries)
        set.colors = ChartColorTemplates.colorful()
        let data = PieChartData(dataSet: set)
        pieChart.data = data
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
    }
    
    func setLayouts() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -Constants.screenHeight/9),
        tableView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 16),
        tableView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -16),
        tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            
            updateButton.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            updateButton.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -10),
        ])
    }
}

extension ExpenseViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle ,forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        let spendName = viewModel.expense[indexPath.row].spendsName
        
        viewModel.deleteExpense(expenseName: spendName) { [weak self] error in
            if let error {
                AlertManager.showDeleteExpenseErrorAlert(on: self ?? UIViewController(), with: error)
            }
  
        }
        
        self.viewModel.expense.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
}

extension ExpenseViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ExpenseCell.identifier, for: indexPath) as? ExpenseCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.selectedBackgroundView = .none
        
        let expense = viewModel.expense[indexPath.row]
        cell.configCell(with: expense)
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .delete
    }
   
}




extension ExpenseViewController: ChartViewDelegate {
    //
}


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
