import UIKit

final class ExpenseCell: UITableViewCell {
    //MARK: Constants
    public static let identifier = "ExpenseCell"
    
    private let categoryNameLabel = UILabel()
    private let spendsNameLabel = UILabel()
    private let amountLabel = UILabel()
    private let dateLabel = UILabel()
    
    private let blurEffect = UIBlurEffect(style: .dark)

    
    //MARK: Variables
    private(set) var expense: ExpenseModel!
    private lazy var cellHeight = Constants.screenHeight / 7.8
    private lazy var vStack = createStackView(axis: .vertical)
    private lazy var blurContainer = createBlurContriner(blurEffect: blurEffect)
    //MARK: Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setBackground()
        setupUI()
        self.backgroundColor = .clear
        NotificationCenter.default.addObserver(self, selector: #selector(updateCurrencySymbol), name: .currencyDidChange, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Methods
    
    public func configCell(with expense: ExpenseModel) {
        self.expense = expense
        categoryNameLabel.text = expense.categoryName
        spendsNameLabel.text = expense.spendsName
        dateLabel.text = expense.formattedDate()
        
        updateCurrencySymbol()
    }
    
    @objc private func updateCurrencySymbol() {
        let symbol = CurrencyManager.shared.currentSymbol.rawValue
        self.amountLabel.text = "- \(symbol)\(expense.amount)"
        
    }
}

//MARK: - Extensions
private extension ExpenseCell {
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
        self.addSubview(vStack)
        
        vStack.addArrangedSubview(categoryNameLabel)
        vStack.addArrangedSubview(dateLabel)
        vStack.translatesAutoresizingMaskIntoConstraints = false
       
        self.addSubview(amountLabel)
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(spendsNameLabel)
        spendsNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        categoryNameLabel.textColor = .white
        categoryNameLabel.font = .systemFont(ofSize: 14, weight: .light)
        
        spendsNameLabel.textColor = .white
        spendsNameLabel.font = .systemFont(ofSize: 22, weight: .medium)
        
        amountLabel.textColor = .systemRed
        amountLabel.font = .systemFont(ofSize: 18, weight: .medium)
        
        dateLabel.textColor = .systemGray
        dateLabel.font = .systemFont(ofSize: 12, weight: .medium)
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: Constants.screenHeight / 9),
            spendsNameLabel.topAnchor.constraint(equalTo: blurContainer.topAnchor, constant: 16),
            spendsNameLabel.leftAnchor.constraint(equalTo: blurContainer.leftAnchor, constant: 16),
            
            vStack.topAnchor.constraint(equalTo: spendsNameLabel.bottomAnchor, constant: 4),
            vStack.leftAnchor.constraint(equalTo: blurContainer.leftAnchor, constant: 16),
            
            amountLabel.centerYAnchor.constraint(equalTo: blurContainer.centerYAnchor),
            amountLabel.rightAnchor.constraint(equalTo: blurContainer.rightAnchor, constant: -16)
        ])
    }
    
    
}
