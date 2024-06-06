import UIKit
import DGCharts

final class StatsViewController: UIViewController {
    //MARK: Constants
    private let label = UILabel()
    private let lineChart = LineChartView()
    private let segmentedControll = UISegmentedControl(items: ["Incomes", "Expense"])
    private let tableView = UITableView()
    private let viewModel: StatsViewModel
    //MARK: Variables
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
        lineChart.delegate = self
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupLineChart()
    }
    
    //MARK: Methods
    
  
}

//MARK: - Extensions
private extension StatsViewController {
    func setupLineChart() {
        
        lineChart.frame = CGRect(x: 0, y: 0,
                                width: self.view.frame.size.width / 1.5,
                                height: self.view.frame.size.width / 1.5)
        lineChart.center = self.view.center
       
        lineChart.center.x = self.view.center.x
        lineChart.center.y = self.view.frame.size.height / 3.5
        
        self.view.addSubview(lineChart)
        
        var entries = [ChartDataEntry]()
        
        for x in 0..<7 {
            entries.append(ChartDataEntry(x: Double(x),
                                             y: Double(x)))
        }
        
        let set = LineChartDataSet(entries: entries)
        set.colors = ChartColorTemplates.material()
        let data = LineChartData(dataSet: set)
        lineChart.data = data
    }
    
    func setupUI() {
        self.view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Stats"
        label.font = .systemFont(ofSize: 24, weight: .medium)
        
        self.view.addSubview(segmentedControll)
        segmentedControll.translatesAutoresizingMaskIntoConstraints = false
        segmentedControll.backgroundColor = .gray
        segmentedControll.selectedSegmentIndex = 0
        
        
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(StatsCell.self, forCellReuseIdentifier: StatsCell.identifier)
        tableView.backgroundColor = .clear
        tableView.isScrollEnabled = false
    }
    
    func setLayots() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 70),
            label.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            
            segmentedControll.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            segmentedControll.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            tableView.topAnchor.constraint(equalTo: segmentedControll.bottomAnchor, constant: 16),
            tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16),
            tableView.heightAnchor.constraint(equalToConstant: 230)
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StatsCell.identifier, for: indexPath) as? StatsCell else { return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.selectedBackgroundView = .none
        
//        let income = viewModel.incomesSource[indexPath.row]
//        cell.configCell(with: income)
        return cell
    }
    
    
}
