import UIKit
import DGCharts
import Charts

enum StatsState {
    case incomes
    case expense
}

final class StatsViewController: UIViewController {
    //MARK: Constants
    private let label = UILabel()
    private let lineChart = LineChartView()
    private let segmentedControll = UISegmentedControl(items: ["Incomes", "Expense"])
    private let tableView = UITableView()
    private let viewModel: StatsViewModel
    //MARK: Variables
    private var currentStatState: StatsState = .incomes
   
    
    init(viewModel: StatsViewModel = StatsViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        setupUI()
        setLayots()
        
        fetchIncome()
        fetchExpense()
        
        lineChart.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        
       
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupLineChart()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchIncome()
        fetchExpense()
        tableView.reloadData()
        
    }
    
    //MARK: Methods
    
    @objc private func segmentedControlChanged(_ sender: UISegmentedControl) {
        currentStatState = sender.selectedSegmentIndex == 0 ? .incomes : .expense
        updateLineChart()
        tableView.reloadData()
    }
    
    
    //MARK: - Networking
    private func fetchIncome() {
        self.viewModel.fetchIncome { [weak self] income, error in
            if let income {
                self?.viewModel.incomesSource = income
                self?.updateLineChart()
                self?.tableView.reloadData()
            } else if let error {
                //TODO: -
                AlertManager.ShowFetchingUserError(on: self ?? UIViewController(), with: error)
            }
            
        }
    }
    
    private func fetchExpense() {
        self.viewModel.fetchExpense(completion: { [weak self] expense, error in
            if let expense {
                self?.viewModel.expenseSource = expense
                self?.updateLineChart()
                self?.tableView.reloadData()
            } else if let error {
                AlertManager.ShowFetchingUserError(on: self ?? UIViewController(), with: error)
            }
        })
    }
}

//MARK: - Extensions
private extension StatsViewController {
    func setupUI() {
        self.view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Stats"
        label.font = .systemFont(ofSize: 24, weight: .medium)
        
        self.view.addSubview(segmentedControll)
        segmentedControll.translatesAutoresizingMaskIntoConstraints = false
        segmentedControll.backgroundColor = .gray
        segmentedControll.selectedSegmentIndex = 0
        segmentedControll.addTarget(self, action: #selector(segmentedControlChanged(_:)), for: .valueChanged)
        
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(StatsCell.self, forCellReuseIdentifier: StatsCell.identifier)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        
    
    }
    
    func setLayots() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 70),
            label.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            
            segmentedControll.topAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -25),
            segmentedControll.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            tableView.topAnchor.constraint(equalTo: segmentedControll.bottomAnchor, constant: 16),
            tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension StatsViewController: ChartViewDelegate {
    
}

extension StatsViewController: UITableViewDelegate {
    
}

extension StatsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StatsCell.identifier, for: indexPath) as? StatsCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.selectedBackgroundView = .none
        
        switch currentStatState {
        case .incomes:
            cell.configIncomesCell()
        case .expense:
            cell.configExpenseCell()
        }
        
        return cell
    }
}

//MARK: - Chart Setting
private extension StatsViewController {
        private func setupLineChart() {
            lineChart.frame = CGRect(x: 0, y: 0,
                                     width: self.view.frame.size.width ,
                                     height: self.view.frame.size.width / 1.5)
            lineChart.center = self.view.center
            lineChart.center.x = self.view.center.x
            lineChart.center.y = self.view.frame.size.height / 3.5
            
            self.view.addSubview(lineChart)
            
            var entries = [ChartDataEntry]()
            var dataSetLabel = ""
            
            switch currentStatState {
            case .incomes:
                let incomeData = viewModel.incomesSource.sorted { $0.date < $1.date }
                
                for (_, income) in incomeData.enumerated() {
                    let timeIntervalForDate = income.date.timeIntervalSince1970
                    let entry = ChartDataEntry(x: timeIntervalForDate, y: income.amount)
                    entries.append(entry)
                }
                
                dataSetLabel = "Incomes" 
                
            case .expense:
                let expenseData = viewModel.expenseSource.sorted { $0.date < $1.date }
                
                for (_, expense) in expenseData.enumerated() {
                    let timeIntervalForDate = expense.date.timeIntervalSince1970
                    let entry = ChartDataEntry(x: timeIntervalForDate, y: expense.amount)
                    entries.append(entry)
                }
                
                dataSetLabel = "Expenses"
            }
            
            let set = LineChartDataSet(entries: entries, label: dataSetLabel)
            set.colors = ChartColorTemplates.material()
            set.drawIconsEnabled = false
            set.drawValuesEnabled = false
            
            let data = LineChartData(dataSet: set)
            lineChart.data = data
            
            let xAxis = lineChart.xAxis
            xAxis.valueFormatter = DateValueFormatter()
            xAxis.granularity = 1
            xAxis.labelPosition = .bottom
            
            let legend = lineChart.legend
            legend.enabled = true
            legend.horizontalAlignment = .center
            legend.verticalAlignment = .bottom
            legend.orientation = .horizontal
            legend.drawInside = false
            legend.form = .circle
            
            let legendEntry = LegendEntry(label: "")
            legend.setCustom(entries: [legendEntry])
            
            lineChart.notifyDataSetChanged()
        }    
    
    func updateLineChart() {
        var entries = [ChartDataEntry]()
        switch currentStatState {
        case .incomes:
            let incomeData = viewModel.incomesSource.sorted { $0.date < $1.date }
            
            for (_, income) in incomeData.enumerated() {
                let timeIntervalForDate = income.date.timeIntervalSince1970
                let entry = ChartDataEntry(x: timeIntervalForDate, y: income.amount)
                entries.append(entry)
            }
            
            let set = LineChartDataSet(entries: entries)
            set.colors = ChartColorTemplates.material()
            let data = LineChartData(dataSet: set)
            lineChart.data = data
            
            let xAxis = lineChart.xAxis
            xAxis.valueFormatter = DateValueFormatter()
            xAxis.granularity = 1
            xAxis.labelPosition = .bottom
            
        case .expense:
            let expenseData = viewModel.expenseSource.sorted { $0.date < $1.date }
            
            for (_, expense) in expenseData.enumerated() {
                let timeIntervalForDate = expense.date.timeIntervalSince1970
                let entry = ChartDataEntry(x: timeIntervalForDate, y: expense.amount)
                entries.append(entry)
            }
            
            let set = LineChartDataSet(entries: entries)
            set.colors = ChartColorTemplates.material()
            let data = LineChartData(dataSet: set)
            lineChart.data = data
            
            let xAxis = lineChart.xAxis
            xAxis.valueFormatter = DateValueFormatter()
            xAxis.granularity = 1
            xAxis.labelPosition = .bottom
        }
    }
}

