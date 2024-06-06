import UIKit
import DGCharts

final class IncomeViewController: UIViewController {
    //MARK: Constants
    private let tableView = UITableView()
    private var refreshControl = UIRefreshControl()
    private let pieChart = PieChartView()
    private let viewModel: IncomeViewModel
    private let buttonHStack: UIStackView = {
        let hs = UIStackView()
        hs.axis = .horizontal
        hs.spacing = 10
        return hs
    }()
    
 
    
    
    //MARK: Variables
    private lazy var updateButton = createRoundButton(imageName: "arrow.triangle.2.circlepath", selector: #selector(updateButtonTapped))
    
    private lazy var addIncomeButton = createRoundButton(imageName: "plus", selector: #selector(addIncomeButtonTapped))
    
    //MARK: Lifecycle
    init(viewModel: IncomeViewModel = IncomeViewModel()) {
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
        
        
        fetchIncome()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupPieChart()
    }
    //MARK: Methods
    
    private func fetchIncome() {
        self.viewModel.fetchIncome { [weak self] income, error in
            if let income {
                self?.viewModel.income = income
                self?.updateUI()
            } else if let error {
                AlertManager.ShowFetchingUserError(on: self ?? UIViewController(), with: error)
            }
        }
    }
    
    @objc private func refreshData() {
        fetchIncome()
    }
    
    @objc private func addIncomeButtonTapped() {
        present(AddNewIncomeViewController(), animated: true)
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
private extension IncomeViewController {
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
        tableView.separatorStyle = .none
        tableView.register(IncomeCell.self, forCellReuseIdentifier: IncomeCell.identifier)
        
        
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
        self.view.addSubview(buttonHStack)
        buttonHStack.translatesAutoresizingMaskIntoConstraints = false
        
        buttonHStack.addArrangedSubview(addIncomeButton)
        buttonHStack.addArrangedSubview(updateButton)
        
        
    }
    
    func setLayouts() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -Constants.screenHeight/14),
            tableView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            tableView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            
            buttonHStack.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            buttonHStack.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -10),
            buttonHStack.heightAnchor.constraint(equalToConstant: 50),
          
        ])
    }
}

extension IncomeViewController: UITableViewDelegate {
    //
    
}

extension IncomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(viewModel.income.count)
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: IncomeCell.identifier, for: indexPath) as? IncomeCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.selectedBackgroundView = .none
        
        let income = viewModel.income[indexPath.row]
        cell.configCell(with: income)
        return cell
    }
    
    
}


extension IncomeViewController: ChartViewDelegate {
    //
}


extension IncomeViewController {
    func setExpense() {
        self.viewModel.onIncomeUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.refreshControl.endRefreshing()
            }
        }
    }
}
