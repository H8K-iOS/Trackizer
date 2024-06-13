import UIKit

final class StatsCell: UITableViewCell {
    //MARK: Constants
    static let identifier = "StatsCell"
    
    private let typeLabel = UILabel()
    let typeBy = UILabel()
    private let typeIcon = UIImageView()
    private let currencyLabel = UILabel()
    private let amountLabel = UILabel()
    private let transactionCount = UILabel()
    private let blurEffect = UIBlurEffect(style: .dark)
    private let authService = AuthService.shared
    
    
    private let categoryCountLabel = UILabel()
    private let countView = UIView()
    //MARK: Variables
    private(set) var income: IncomeModel!
    private(set) var expense: ExpenseModel!
    
    private lazy var blurContainer = createBlurContriner(blurEffect: blurEffect)
    private lazy var hStack = createStackView(axis: .horizontal)
    private lazy var cellHeight = Constants.screenHeight / 3
    //MARK: Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setBackground()
        setupCountView()
        setupUI()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: Methods
    
    public func configIncomesCell() {
        authService.calculateIncome { [weak self] count, total, categotyCount in
            DispatchQueue.main.async {
                self?.typeLabel.text = "Incomes"
                self?.amountLabel.text = "+ $\(total)"
                self?.amountLabel.textColor = .systemGreen.withAlphaComponent(0.8)
                self?.transactionCount.text = "You have made a total of \(count) transactions"
                self?.typeBy.text = "Incomes by"
                self?.categoryCountLabel.text = "🤑 \(categotyCount)"
            }
        }
    }
    
    public func configExpenseCell() {
        authService.calculateExpense { [weak self] count, total, categoryCount in
            DispatchQueue.main.async {
                self?.typeLabel.text = "Expense"
                self?.amountLabel.text = "- $\(total)"
                self?.amountLabel.textColor = .systemRed.withAlphaComponent(0.8)
                self?.transactionCount.text = "You have made a total of \(count) transactions"
                self?.typeBy.text = "Expense by"
                self?.categoryCountLabel.text = "🤘 \(categoryCount)"
            }
        }
    }
}

//MARK: - Extensions
private extension StatsCell {
    func setupCountView() {
        
        countView.backgroundColor = .black.withAlphaComponent(0.1)
        countView.layer.cornerRadius = 12
        countView.layer.borderColor = UIColor.systemGray.withAlphaComponent(0.5).cgColor
        countView.layer.borderWidth = 1
        
        
        countView.addSubview(typeBy)
        typeBy.translatesAutoresizingMaskIntoConstraints = false
        typeBy.text = ""
        typeBy.textColor = .systemGray
        
        
        categoryCountLabel.translatesAutoresizingMaskIntoConstraints = false
        countView.addSubview(categoryCountLabel)
        categoryCountLabel.text = ""
        categoryCountLabel.font = .systemFont(ofSize: 28)
        categoryCountLabel.textColor = .white
        
        let categoryLabel = UILabel()
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        countView.addSubview(categoryLabel)
        categoryLabel.text = "Categories"
        categoryLabel.textColor = .systemGray
        categoryLabel.font = .systemFont(ofSize: 12)
        
        
        NSLayoutConstraint.activate([
            typeBy.topAnchor.constraint(equalTo: countView.topAnchor, constant: 4),
            typeBy.centerXAnchor.constraint(equalTo: countView.centerXAnchor),
       
            categoryCountLabel.centerYAnchor.constraint(equalTo: countView.centerYAnchor),
            categoryCountLabel.centerXAnchor.constraint(equalTo: countView.centerXAnchor),
            
            categoryLabel.centerXAnchor.constraint(equalTo: countView.centerXAnchor),
            categoryLabel.bottomAnchor.constraint(equalTo: countView.bottomAnchor, constant: -8)
        ])
    }
    
    func setBackground() {
        self.addSubview(blurContainer)
        
        self.backgroundColor = .clear
        self.clipsToBounds = true
        self.layer.cornerRadius = blurContainer.layer.cornerRadius
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: cellHeight),
            
            blurContainer.topAnchor.constraint(equalTo: self.topAnchor),
            blurContainer.leftAnchor.constraint(equalTo: self.leftAnchor),
            blurContainer.rightAnchor.constraint(equalTo: self.rightAnchor),
            blurContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
        ])
    }

    func setupUI() {
        self.layer.cornerRadius = 25
        self.clipsToBounds = true
        
        self.addSubview(typeLabel)
        self.addSubview(amountLabel)
        self.addSubview(currencyLabel)
        self.addSubview(transactionCount)
        
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        currencyLabel.translatesAutoresizingMaskIntoConstraints = false
        transactionCount.translatesAutoresizingMaskIntoConstraints = false
        
        typeLabel.text = "Incomes"
        typeLabel.textColor = .white
        typeLabel.font = .systemFont(ofSize: 20, weight: .medium)
        
        amountLabel.text = "+ $0"
        amountLabel.textColor = .systemGreen.withAlphaComponent(0.8)
        amountLabel.font = .systemFont(ofSize: 24, weight: .medium)
        
        currencyLabel.text = "USD"
        currencyLabel.textColor = .white
        currencyLabel.font = .systemFont(ofSize: 12, weight: .medium)
        
        transactionCount.text = "You have made a total of 0 transactions"
        transactionCount.textColor = .white
        transactionCount.font = .systemFont(ofSize: 14, weight: .light)
        transactionCount.textAlignment = .center
        transactionCount.layer.cornerRadius = 10
        transactionCount.layer.borderWidth = 1
        transactionCount.layer.borderColor = UIColor.systemGray.withAlphaComponent(0.5).cgColor
        transactionCount.clipsToBounds = true
        transactionCount.backgroundColor = .black.withAlphaComponent(0.1)
        
        self.addSubview(countView)
        countView.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        NSLayoutConstraint.activate([
            
            
            typeLabel.topAnchor.constraint(equalTo: blurContainer.topAnchor, constant: 16),
            typeLabel.leftAnchor.constraint(equalTo: blurContainer.leftAnchor, constant: 16),
            
            amountLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 16),
            amountLabel.leftAnchor.constraint(equalTo: blurContainer.leftAnchor, constant: 16),
            
            currencyLabel.topAnchor.constraint(equalTo: blurContainer.topAnchor, constant: 16),
            currencyLabel.rightAnchor.constraint(equalTo: blurContainer.rightAnchor, constant: -16),
            
            transactionCount.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 16),
            transactionCount.rightAnchor.constraint(equalTo: blurContainer.rightAnchor, constant: -16),
            transactionCount.leftAnchor.constraint(equalTo: blurContainer.leftAnchor, constant: 16),
            transactionCount.heightAnchor.constraint(equalToConstant: 40),
            
            countView.topAnchor.constraint(equalTo: transactionCount.bottomAnchor, constant: 8),
            countView.leftAnchor.constraint(equalTo: blurContainer.leftAnchor, constant: 16),
            countView.rightAnchor.constraint(equalTo: blurContainer.centerXAnchor),
            countView.widthAnchor.constraint(equalToConstant: Constants.screenHeight/5),
            countView.bottomAnchor.constraint(equalTo: blurContainer.bottomAnchor, constant: -16)
        ])

    }
}
