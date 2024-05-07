import UIKit

final class CategorieCell: UITableViewCell {
    //MARK: Constants
    static let identifier = "CategorieCell"
    private let screenHeight = UIScreen.main.bounds.height
    private let blurEffect = UIBlurEffect(style: .dark)
    private let blurContaienr: UIVisualEffectView = {
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
    
    private lazy var labelsVStack = createStackView(axis: .vertical)
    private lazy var moneyVStack = createStackView(axis: .vertical)
    private lazy var totalHStack = createStackView(axis: .horizontal)
    
    //MARK: Variables
    private lazy var cellHeight = screenHeight / 8.8
    
    //MARK: Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: Methods
    
    
}

//MARK: - Extensions
private extension CategorieCell {
    func setupUI() {
        self.addSubview(blurContaienr)
        blurContaienr.effect = blurEffect
        
        self.addSubview(totalHStack)
        self.addSubview(categoryImageView)
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
        self.layer.cornerRadius = blurContaienr.layer.cornerRadius
        
        categoryNameLabel.text = "Security"
        leftToSpendLabel.text = "$375 left to spend"
        spendsLabel.text = "$2535.99"
        totalSpendsLabel.text = "of $60000"
        
        categoryNameLabel.textColor = .white
        categoryNameLabel.font = .systemFont(ofSize: 20, weight: .heavy)
        
        leftToSpendLabel.textColor = GrayColors.gray30.OWColor
        leftToSpendLabel.font = .systemFont(ofSize: 15)
        
        
        spendsLabel.textColor = .white
        spendsLabel.font = .systemFont(ofSize: 20, weight: .heavy)
        
        totalSpendsLabel.textColor = GrayColors.gray30.OWColor
        totalSpendsLabel.font = .systemFont(ofSize: 15)
        
        categoryImageView.image = #imageLiteral(resourceName: "Security.png")
        categoryImageView.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: cellHeight),
            
            blurContaienr.topAnchor.constraint(equalTo: self.topAnchor),
            blurContaienr.leftAnchor.constraint(equalTo: self.leftAnchor),
            blurContaienr.rightAnchor.constraint(equalTo: self.rightAnchor),
            blurContaienr.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            
            categoryImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12),
            categoryImageView.centerYAnchor.constraint(equalTo: totalHStack.centerYAnchor),
            categoryImageView.widthAnchor.constraint(equalToConstant: 32),
            categoryImageView.heightAnchor.constraint(equalToConstant: 32),
            
            totalHStack.topAnchor.constraint(equalTo: blurContaienr.topAnchor, constant: 8),
            totalHStack.rightAnchor.constraint(equalTo: blurContaienr.rightAnchor, constant: -12),
            totalHStack.bottomAnchor.constraint(equalTo: blurContaienr.bottomAnchor, constant: -20),
            totalHStack.leftAnchor.constraint(equalTo: categoryImageView.rightAnchor, constant: 15),
            
        ])
    }
}



