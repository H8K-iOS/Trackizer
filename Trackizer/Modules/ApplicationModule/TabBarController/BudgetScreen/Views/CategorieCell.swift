import UIKit

final class CategorieCell: UITableViewCell {
    //MARK: Constants
    static let identifier = "CategorieCell"
    
    //MARK: Variables
    
    
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
        
        
        self.backgroundColor = .darkGray
        
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 84)
        ])
    }
}



