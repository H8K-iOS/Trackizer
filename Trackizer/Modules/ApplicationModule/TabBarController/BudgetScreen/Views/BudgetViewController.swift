import UIKit

final class BudgetViewController: UIViewController {
    //MARK: Constants
    private let tableView = UITableView()
    private let vStack = UIStackView()
    
    //TODO: - progress view
    private var backgroundLayer: CAShapeLayer?
    private var progressLayerGreen: CAShapeLayer?
    private var progressLayerOrange: CAShapeLayer?
    private var progressLayerPurple: CAShapeLayer?
    
    private let firstCategorie = 30.211
    private let secondeCategorie = 212.2555
    private let thirdCategorie = 224.12222
    private var categorySum: Double {
        return Double(self.firstCategorie) + Double(self.secondeCategorie) + Double(self.thirdCategorie)
    }
    private let total = 300.0
    
    let budgetLabel = UILabel()
    let budgetDescriptionLabel = UILabel()
    let container = UIView()
    
    //MARK: Variables
    private lazy var addCategoryButton = createButton(type: .category, selector: #selector(addCategoryButtonTapped))
    
    //MARK: Lifecycle
        //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setBackground()

        setupUI()
        setupRoundView()
        setupLayots()
        
        tableView.delegate = self
        tableView.dataSource = self
        setupRoundViewProgressLayers()
        check()
    }
        //MARK: ViewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        backgroundLayer?.path = configProgressPath()
        progressLayerGreen?.path = configProgressPath()
        progressLayerOrange?.path = configProgressPath()
        progressLayerPurple?.path = configProgressPath()
    }
    
        //MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        startAnimation(first: Double(firstCategorie), second: Double(secondeCategorie), third: Double(thirdCategorie), ofLast: Double(total))
    }
    
    //MARK: Methods
    
    //TODO: -
    private func addSpends() {
        present(AddSpendsViewController(), animated: true)
    }
    
    @objc func addCategoryButtonTapped() {

        present(AddNewCategoryViewController(), animated: true)
    }
    
    private func check() {
        if categorySum > total {
            budgetLabel.textColor = .red
        }
    }
}

//MARK: - Extensions
    //MARK: - VC UI
private extension BudgetViewController {
    func setupUI() {
        //TODO: -
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.register(CategorieCell.self, forCellReuseIdentifier: CategorieCell.identifier)
        
        
        self.view.addSubview(addCategoryButton)
        
        
        addCategoryButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupLayots() {
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            tableView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            tableView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 3),
            tableView.topAnchor.constraint(equalTo: container.bottomAnchor),
            
            addCategoryButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 16),
            addCategoryButton.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            addCategoryButton.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -16),
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
        
        budgetLabel.text = "$\(categorySum.rounded(toPlaces: 2))"
        budgetLabel.font = .systemFont(ofSize: 34, weight: .heavy)
        budgetLabel.textColor = .white
        
        budgetDescriptionLabel.text = "of $\(total.rounded(toPlaces: 2)) budget"
        budgetDescriptionLabel.font = .systemFont(ofSize: 16, weight: .medium)
        budgetDescriptionLabel.textColor = .darkGray
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            container.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            container.widthAnchor.constraint(equalToConstant: 210),
            container.heightAnchor.constraint(equalToConstant: 120),
            
            budgetLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 4),
            budgetLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor),
        ])
        
    }

    //MARK: Progress View Setup
    func configBackgroundLayer() -> CAShapeLayer {
        let bgLayer = CAShapeLayer()
        bgLayer.path = configProgressPath()
        bgLayer.fillColor = nil
        bgLayer.lineCap = .round
        bgLayer.lineWidth = 8
        bgLayer.strokeColor = UIColor.gray.cgColor
        return bgLayer
    }
    
    func configProgressLayer(color: UIColor) -> CAShapeLayer {
        let progressLayer = CAShapeLayer()
        progressLayer.path = configProgressPath()
        progressLayer.fillColor = nil
        progressLayer.lineCap = .round
        progressLayer.lineWidth = 14
        progressLayer.strokeColor = color.cgColor
        progressLayer.strokeEnd = 0
        
        progressLayer.shadowColor = UIColor.white.cgColor
        progressLayer.shadowOffset = CGSize(width: 0, height: 0)
        progressLayer.shadowOpacity = 0.4
        progressLayer.shadowRadius = 5
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
    
    func setupRoundViewProgressLayers() {
        let backgroundLayer = configBackgroundLayer()
        container.layer.addSublayer(backgroundLayer)
        self.backgroundLayer = backgroundLayer
        
        let progressLayerGreen = configProgressLayer(color: AccentSecondarySection.accentS100.OWColor.withAlphaComponent(0.9))
        container.layer.insertSublayer(progressLayerGreen,
                                       above: backgroundLayer)
        self.progressLayerGreen = progressLayerGreen
        
        let progressLayerOrange = configProgressLayer(color: AccentPrimarySection.accentP100.OWColor.withAlphaComponent(0.9))
        container.layer.insertSublayer(progressLayerOrange,
                                       above: backgroundLayer)
        self.progressLayerOrange = progressLayerOrange
        
        let progressLayerPurple = configProgressLayer(color: PrimarySection.primary20.OWColor.withAlphaComponent(0.9))
        container.layer.insertSublayer(progressLayerPurple,
                                       above: backgroundLayer)
        self.progressLayerPurple = progressLayerPurple
    }
    
    //MARK: Progress View Animation
   
    func startAnimation(first: Double, second: Double, third: Double, ofLast: Double) {
        let total = CGFloat(ofLast)
        let progress1 = CGFloat(first) / total
        let progress2 = CGFloat(second) / total
        let progress3 = CGFloat(third) / total
        
        progressLayerGreen?.strokeEnd = progress1
        progressLayerOrange?.strokeEnd = progress1 + progress2
        progressLayerPurple?.strokeEnd = progress1 + progress2 + progress3
        
        animateProgress(for: progressLayerGreen, to: progress1)
        animateProgress(for: progressLayerOrange, to: progress1 + progress2)
        animateProgress(for: progressLayerPurple, to: progress1 + progress2 + progress3)
    }
    
    //Function to calculate progress for category
    func animateProgress(for layer: CAShapeLayer?, to value: CGFloat) {
        if let layer {
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = 0
            animation.toValue = value
            animation.duration = 1.5
            layer.strokeEnd = value
            layer.add(animation, forKey: "strokeEndAnimation")
        }
    }
}

//MARK: - Table View
extension BudgetViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        addSpends()
    }
}

extension BudgetViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategorieCell.identifier,
                                                 for: indexPath) as? CategorieCell else { return UITableViewCell() }
        
        cell.selectionStyle = .none
        cell.selectedBackgroundView = .none
        return cell
    }
    
    
}

