import UIKit

final class CategorieCell: UITableViewCell {
    // MARK: - Constants
    public static let identifier = "CategorieCell"
    
    private let blurEffect = UIBlurEffect(style: .dark)
    private let categoryIcon = UILabel()
    private let categoryNameLabel = UILabel()
    private let leftToSpendLabel = UILabel()
    private let spendsLabel = UILabel()
    private let totalSpendsLabel = UILabel()
    
    private let progressLineBackground = CAShapeLayer()
    public let container = UIView()
    
    // MARK: - Variables
    private lazy var cellHeight = Constants.screenHeight / 7.8
    private lazy var labelsVStack = createStackView(axis: .vertical)
    private lazy var moneyVStack = createStackView(axis: .vertical)
    private lazy var totalHStack = createStackView(axis: .horizontal)
    private lazy var blurContainer = createBlurContriner(blurEffect: blurEffect)
    private(set) var budget: BudgetModel!
    
    private var backgroundLayer: CAShapeLayer?
    public var progressLayer: CAShapeLayer?
    private var currentCategoryValue: Double?
    private var totalBudgetForCategory: Double?
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        NotificationCenter.default.addObserver(self, selector: #selector(updateCurrencySymbol), name: .currencyDidChange, object: nil)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setupRoundViewProgressLayers()
        
        backgroundLayer?.path = configProgressPath()
        progressLayer?.path = configProgressPath()
        startAnimation(currentSum: currentCategoryValue ?? 0.0, total: totalBudgetForCategory ?? 0.0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Methods
    public func configCell(with budget: BudgetModel) {
        self.budget = budget
        self.categoryNameLabel.text = budget.categoryName
        self.currentCategoryValue = budget.categorySpent
        self.totalBudgetForCategory = budget.categoryTotalValue
        self.categoryIcon.text = budget.icon
        
        updateCurrencySymbol() 
        
        updateProgressLayer()
    }
    
    private func updateProgressLayer() {
        progressLayer?.removeFromSuperlayer()
        
        let progressLayer = configProgressLayer(color: budget.color)
        container.layer.addSublayer(progressLayer)
        self.progressLayer = progressLayer
        
        startAnimation(currentSum: currentCategoryValue ?? 0.0, total: totalBudgetForCategory ?? 0.0)
    }
    
    @objc private func updateCurrencySymbol() {
        let symbol = CurrencyManager.shared.currentSymbol
        
        self.spendsLabel.text = "\(symbol.rawValue)\(budget.categorySpent)"
        self.totalSpendsLabel.text = "\(symbol.rawValue)\(budget.categoryTotalValue)"
        
        if let currentCategoryValue = currentCategoryValue,
           let totalBudgetForCategory = totalBudgetForCategory,
           currentCategoryValue > totalBudgetForCategory {
            self.spendsLabel.textColor = .systemOrange
            self.leftToSpendLabel.text = "you exceeded the limit by \(symbol.rawValue)\(abs(budget.leftToSpend))"
        } else {
            self.spendsLabel.textColor = .white
            self.leftToSpendLabel.text = "\(symbol.rawValue)\(budget.leftToSpend) left to spend"
        }
    }
}

// MARK: - Extensions
private extension CategorieCell {
    func setupUI() {
        self.addSubview(blurContainer)
        
        self.addSubview(totalHStack)
        self.addSubview(categoryIcon)
        self.addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        totalHStack.translatesAutoresizingMaskIntoConstraints = false
        categoryIcon.translatesAutoresizingMaskIntoConstraints = false
        
        labelsVStack.addArrangedSubview(categoryNameLabel)
        labelsVStack.addArrangedSubview(leftToSpendLabel)
        
        moneyVStack.addArrangedSubview(spendsLabel)
        moneyVStack.addArrangedSubview(totalSpendsLabel)
        totalHStack.addArrangedSubview(labelsVStack)
        totalHStack.addArrangedSubview(moneyVStack)
        
        self.backgroundColor = .clear
        self.clipsToBounds = true
        self.layer.cornerRadius = blurContainer.layer.cornerRadius
        
        moneyVStack.alignment = .trailing
        moneyVStack.spacing = -10
        labelsVStack.spacing = -10
        
        categoryNameLabel.textColor = .white
        categoryNameLabel.font = .systemFont(ofSize: 18, weight: .heavy)
        
        leftToSpendLabel.textColor = GrayColors.gray30.OWColor
        leftToSpendLabel.font = .systemFont(ofSize: 14)
        
        spendsLabel.textColor = .white
        spendsLabel.font = .systemFont(ofSize: 18, weight: .heavy)
        
        totalSpendsLabel.textColor = GrayColors.gray30.OWColor
        totalSpendsLabel.font = .systemFont(ofSize: 14)
        
        categoryIcon.font = .systemFont(ofSize: 30)
        categoryIcon.textAlignment = .center
        
        container.backgroundColor = .clear
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: cellHeight),
            
            blurContainer.topAnchor.constraint(equalTo: self.topAnchor),
            blurContainer.leftAnchor.constraint(equalTo: self.leftAnchor),
            blurContainer.rightAnchor.constraint(equalTo: self.rightAnchor),
            blurContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            
            categoryIcon.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12),
            categoryIcon.centerYAnchor.constraint(equalTo: blurContainer.centerYAnchor, constant: -12),
            
            totalHStack.topAnchor.constraint(equalTo: blurContainer.topAnchor, constant: 16),
            totalHStack.rightAnchor.constraint(equalTo: blurContainer.rightAnchor, constant: -20),
            totalHStack.bottomAnchor.constraint(equalTo: blurContainer.bottomAnchor, constant: -20),
            totalHStack.leftAnchor.constraint(equalTo: categoryIcon.rightAnchor, constant: 15),
            
            container.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 22),
            container.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -22),
            container.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30)
        ])
    }
    
    func setupRoundViewProgressLayers() {
        let backgroundLayer = configBackgroundLayer()
        container.layer.addSublayer(backgroundLayer)
        self.backgroundLayer = backgroundLayer
        
        let progressLayer = configProgressLayer(color: budget.color)
        container.layer.insertSublayer(progressLayer, above: backgroundLayer)
        self.progressLayer = progressLayer
    }
}
