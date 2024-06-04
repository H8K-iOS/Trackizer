import UIKit

final class IncomeCell: UITableViewCell {
    //MARK: Constants
    public static let identifier = "IncomeCell"
    
    
    private let incomeNameLabel = UILabel()
    private let dateLabel = UILabel()
    private let amountLabel = UILabel()
    
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
    
    //MARK: Variables
    private(set) var income: IncomeModel!
    private lazy var cellHeight = Constants.screenHeight / 7.8
    private lazy var hStack = createStackView(axis: .horizontal)
    private lazy var vStack = createStackView(axis: .vertical)
    
    //MARK: Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setBackground()
        setupUI()
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Methods
    
    public func configCell(with income: IncomeModel) {
        self.income = income
        incomeNameLabel.text = income.incomeSource
        dateLabel.text = income.date
        amountLabel.text = "+ $\(income.amount)"
    }
    
}

//MARK: - Extensions
private extension IncomeCell {
    func setBackground() {
        self.addSubview(blurContainer)
        blurContainer.effect = blurEffect
        
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
        vStack.addArrangedSubview(incomeNameLabel)
        vStack.addArrangedSubview(dateLabel)
        self.addSubview(hStack)
        hStack.addArrangedSubview(vStack)
       
        hStack.addArrangedSubview(amountLabel)
        
        hStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.translatesAutoresizingMaskIntoConstraints = false
        
        
        dateLabel.textColor = .white
        dateLabel.font = .systemFont(ofSize: 14, weight: .light)
        
        incomeNameLabel.textColor = .white
        incomeNameLabel.font = .systemFont(ofSize: 22, weight: .medium)
        
        amountLabel.textColor = .systemGreen
        amountLabel.font = .systemFont(ofSize: 18, weight: .medium)
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: Constants.screenHeight / 10),
            
            hStack.leftAnchor.constraint(equalTo: blurContainer.leftAnchor, constant: 16),
            hStack.rightAnchor.constraint(equalTo: blurContainer.rightAnchor, constant: -16),
            hStack.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
    
}
