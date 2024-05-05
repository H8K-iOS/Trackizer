import UIKit

final class BudgetViewController: UIViewController {
    //MARK: Constants
    private let tableView = UITableView()
    
    //TODO: - progress view
    private var backgroundLayer: CAShapeLayer?
    private var progressLayer: CAShapeLayer?
    
    let budgetLabel = UILabel()
    let container = UIView()
    
    //MARK: Variables
    private lazy var addSpendsButton = createButton(type: .budget, selector: #selector(addSpendsButtonTapped))
    private lazy var addCategoryButton = createButton(type: .category, selector: #selector(addCategoryButtonTapped))
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = GrayColors.gray80.OWColor
        setupUI()
        setuproundView()
        setupLayots()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        //TODO: -
        let backgroundLayer = configBackgroundLayer()
        container.layer.addSublayer(backgroundLayer)
        self.backgroundLayer = backgroundLayer
        
        let progressLayer = configProgressLayer()
        container.layer.insertSublayer(progressLayer, above: backgroundLayer)
        self.progressLayer = progressLayer
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        backgroundLayer?.path = configProgressPath()
        progressLayer?.path = configProgressPath()
    }
    //MARK: Methods
    
    //TODO: -
    @objc func addSpendsButtonTapped() {
        //strat progress bar
        
        
        
        print("addSpendsButtonTapped")
    }
    
    @objc func addCategoryButtonTapped() {
        //stop progress bar
        
        
        
        print("addCategoryButtonTapped")
    }
    
}

//MARK: - Extensions
private extension BudgetViewController {
    
    func setupUI() {
        //TODO: -

        
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .gray
        tableView.register(CategorieCell.self, forCellReuseIdentifier: CategorieCell.identifier)
        
        self.view.addSubview(addSpendsButton)
        self.view.addSubview(addCategoryButton)
        
        addSpendsButton.translatesAutoresizingMaskIntoConstraints = false
        addCategoryButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupLayots() {
        NSLayoutConstraint.activate([
        
            addSpendsButton.topAnchor.constraint(equalTo: container.bottomAnchor),
            addSpendsButton.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            addSpendsButton.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            
            tableView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            tableView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            tableView.heightAnchor.constraint(equalToConstant: 268),
            tableView.topAnchor.constraint(equalTo: addSpendsButton.bottomAnchor, constant: 16),
            
            addCategoryButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 16),
            addCategoryButton.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            addCategoryButton.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -16),
        ])
    }
    
}
extension BudgetViewController: UITableViewDelegate {
    
}
extension BudgetViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategorieCell.identifier,
                                                 for: indexPath) as? CategorieCell else { return UITableViewCell() }
        
        return cell 
    }
    
    
}

//MARK: - Round view
extension BudgetViewController  {
    func setuproundView() {
        self.view.addSubview(container)
        container.addSubview(budgetLabel)
    
        container.translatesAutoresizingMaskIntoConstraints = false
        budgetLabel.translatesAutoresizingMaskIntoConstraints = false
        
        container.backgroundColor = .clear
        
        budgetLabel.text = "$32.241,52"
        budgetLabel.font = .systemFont(ofSize: 34, weight: .heavy)
        budgetLabel.textColor = .white
        
        NSLayoutConstraint.activate([
            //container.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            container.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            container.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            container.widthAnchor.constraint(equalToConstant: 210),
            container.heightAnchor.constraint(equalToConstant: 120),
            
            budgetLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 4),
            budgetLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor),
        ])
        
        //TODO: -
    }
    
    
    func configBackgroundLayer() -> CAShapeLayer {
        let bgLayer = CAShapeLayer()
        bgLayer.path = configProgressPath()
        bgLayer.fillColor = nil
        bgLayer.lineCap = .round
        bgLayer.lineWidth = 8
        bgLayer.strokeColor = UIColor.gray.cgColor
        return bgLayer
    }
    
    func configProgressLayer() -> CAShapeLayer {
        let progressLayer = CAShapeLayer()
        progressLayer.path = configProgressPath()
        progressLayer.fillColor = nil
        progressLayer.lineCap = .round
        progressLayer.lineWidth = 8
        progressLayer.strokeColor = UIColor.green.cgColor
        progressLayer.strokeEnd = 0
        return progressLayer
    }
    
    func configProgressPath() -> CGPath {
        UIBezierPath(arcCenter: CGPoint(x: container.bounds.midX, y: container.bounds.midY),
                        radius: 120,
                        startAngle: CGFloat.pi ,
                        endAngle: 2 * CGFloat.pi ,
                        clockwise: true
           ).cgPath
    }
}
