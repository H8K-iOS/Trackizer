import UIKit

final class StatsCell: UITableViewCell {
    //MARK: Constants
    static let identifier = "StatsCell"
    
    let typeLabel = UILabel()
    let typeIcon = UIImageView()
    let currency = UILabel()
    let amount = UILabel()
    let transactionCount = UILabel()
    //MARK: Variables
    private(set) var income: IncomeModel!
    
    //MARK: Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
      
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: Methods
    
    public func configCell(with income: IncomeModel) {
        self.income = income
       
    }
}

//MARK: - Extensions
private extension StatsCell {
    func setupUI() {
        self.backgroundColor = .gray
        self.layer.cornerRadius = 25
        self.clipsToBounds = true
        
        self.addSubview(typeLabel)
        self.addSubview(amount)
        self.addSubview(currency)
        self.addSubview(transactionCount)
        
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        amount.translatesAutoresizingMaskIntoConstraints = false
        currency.translatesAutoresizingMaskIntoConstraints = false
        transactionCount.translatesAutoresizingMaskIntoConstraints = false
        
        typeLabel.text = "Incomes"
        typeLabel.textColor = .white
        typeLabel.font = .systemFont(ofSize: 20, weight: .medium)
        
        amount.text = "+ $2000"
        amount.textColor = .white
        amount.font = .systemFont(ofSize: 24, weight: .medium)
        
        currency.text = "USD"
        currency.textColor = .white
        currency.font = .systemFont(ofSize: 12, weight: .medium)
        
        transactionCount.text = "You have made a total of 5 transactions"
        transactionCount.textColor = .white
        transactionCount.font = .systemFont(ofSize: 14, weight: .light)
        transactionCount.textAlignment = .center
        transactionCount.layer.cornerRadius = 10
        transactionCount.layer.borderWidth = 1
        transactionCount.layer.borderColor = UIColor.gray.cgColor
        transactionCount.clipsToBounds = true
        transactionCount.backgroundColor = .black.withAlphaComponent(0.2)
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: Constants.screenHeight / 4),
            
            typeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            typeLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            
            amount.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 16),
            amount.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            
            currency.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            currency.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            
            transactionCount.topAnchor.constraint(equalTo: amount.bottomAnchor, constant: 16),
            transactionCount.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            transactionCount.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            transactionCount.heightAnchor.constraint(equalToConstant: 40),
        ])

    }
}
