import UIKit

final class CategorieCell: UITableViewCell {
    // MARK: - Constants
    static let identifier = "CategorieCell"
    
    private let blurEffect = UIBlurEffect(style: .dark)
    private let blurContainer: UIVisualEffectView = {
        let view = UIVisualEffectView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 24
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.darkGray.cgColor
        view.backgroundColor = .clear
        view.clipsToBounds = true
        return view
    }()
    private let categoryImageView = UIImageView()
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
    private var backgroundLayer: CAShapeLayer?
    public var progressLayer: CAShapeLayer?
    
    private(set) var budget: BudgetModel!
    
    private var currentCategoryValue: Double?
    private var totalBudgetForCategory: Double?
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
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
    
    // MARK: - Methods
    public func configCell(with budget: BudgetModel) {
        self.budget = budget
            self.categoryNameLabel.text = budget.categoryName
            
            self.spendsLabel.text = "$\(budget.categorySpent)"
            self.currentCategoryValue = budget.categorySpent
            
            self.totalSpendsLabel.text = "$\(budget.categoryTotalValue)"
            self.totalBudgetForCategory = budget.categoryTotalValue
        
           
        
            
            if let currentCategoryValue = currentCategoryValue, let totalBudgetForCategory = totalBudgetForCategory, currentCategoryValue > totalBudgetForCategory {
                self.spendsLabel.textColor = .systemOrange
                self.leftToSpendLabel.text = "you exceeded the limit by $\(abs(budget.leftToSpend ?? 0))"
                self.leftToSpendLabel.font = .systemFont(ofSize: 12)
            } else {
                self.spendsLabel.textColor = .white
                self.leftToSpendLabel.text = "$\(budget.leftToSpend ?? 0) left to spend"
                self.leftToSpendLabel.font = .systemFont(ofSize: 14)
            }
            
            updateProgressLayer()
    }
    
    private func updateProgressLayer() {
            progressLayer?.removeFromSuperlayer()
            
            let progressLayer = configProgressLayer(color: budget.color)
            container.layer.addSublayer(progressLayer)
            self.progressLayer = progressLayer
            
            startAnimation(currentSum: currentCategoryValue ?? 0.0, total: totalBudgetForCategory ?? 0.0)
        }
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        self.categoryNameLabel.text = nil
//        self.spendsLabel.text = nil
//        self.totalSpendsLabel.text = nil
//        
//        self.currentCategoryValue = nil
//        self.totalBudgetForCategory = nil
//        
//        backgroundLayer?.removeFromSuperlayer()
//        progressLayer?.removeFromSuperlayer()
//        
//        backgroundLayer = nil
//        progressLayer = nil
//    }
}

// MARK: - Extensions
private extension CategorieCell {
    func setupUI() {
        self.addSubview(blurContainer)
        blurContainer.effect = blurEffect
        
        self.addSubview(totalHStack)
        self.addSubview(categoryImageView)
        self.addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        totalHStack.translatesAutoresizingMaskIntoConstraints = false
        categoryImageView.translatesAutoresizingMaskIntoConstraints = false
        
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
        
        categoryImageView.image = #imageLiteral(resourceName: "Security.png")
        categoryImageView.contentMode = .scaleAspectFit
        
        container.backgroundColor = .clear
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: cellHeight),
            
            blurContainer.topAnchor.constraint(equalTo: self.topAnchor),
            blurContainer.leftAnchor.constraint(equalTo: self.leftAnchor),
            blurContainer.rightAnchor.constraint(equalTo: self.rightAnchor),
            blurContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            
            categoryImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12),
            categoryImageView.centerYAnchor.constraint(equalTo: totalHStack.centerYAnchor),
            categoryImageView.widthAnchor.constraint(equalToConstant: 32),
            categoryImageView.heightAnchor.constraint(equalToConstant: 32),
            
            totalHStack.topAnchor.constraint(equalTo: blurContainer.topAnchor, constant: 16),
            totalHStack.rightAnchor.constraint(equalTo: blurContainer.rightAnchor, constant: -20),
            totalHStack.bottomAnchor.constraint(equalTo: blurContainer.bottomAnchor, constant: -20),
            totalHStack.leftAnchor.constraint(equalTo: categoryImageView.rightAnchor, constant: 15),
            
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
      }}
