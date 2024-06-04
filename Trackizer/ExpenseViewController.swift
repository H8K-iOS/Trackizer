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
        
        setBackground()
        setupUI()
        setLayouts()
        
        tableView.dataSource = self
        tableView.delegate = self
        pieChart.delegate = self
        
        
        fetchExpense()
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
        
        NSLayoutConstraint.activate([
        
        
        
        ])
    }
    
    func setupUI() {
        self.view.addSubview(tableView)
        tableView.addSubview(refreshControl)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.register(ExpenseCell.self, forCellReuseIdentifier: ExpenseCell.identifier)
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    func setLayouts() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -Constants.screenHeight/9),
        tableView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 16),
        tableView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -16),
        tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -40)
        ])
    }
}

extension ExpenseViewController: UITableViewDelegate {
    //
    
}

extension ExpenseViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(viewModel.expense.count)
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
