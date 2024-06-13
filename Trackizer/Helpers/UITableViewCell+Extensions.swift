import UIKit

extension UITableViewCell {
    func createBlurContriner(blurEffect: UIBlurEffect) -> UIVisualEffectView{
        let view = UIVisualEffectView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 24
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.darkGray.cgColor
        view.backgroundColor = .clear
        view.clipsToBounds = true
        view.effect = blurEffect
        return view
    }
    
    
}

extension StatsCell {
    func createSquareView(text: String, categoryCount: Int) -> UIView{
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.1)
        view.layer.cornerRadius = 12
        view.layer.borderColor = UIColor.systemGray.withAlphaComponent(0.5).cgColor
        view.layer.borderWidth = 1
        view.widthAnchor.constraint(equalToConstant: Constants.screenHeight/5.5).isActive = true
        
        
        let label = UILabel()
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.textColor = .systemGray
        
        let categoryCountLabel = UILabel()
        categoryCountLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(categoryCountLabel)
        categoryCountLabel.text = "✊" + "\(categoryCount)"
        categoryCountLabel.font = .systemFont(ofSize: 28)
        categoryCountLabel.textColor = .white
        
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 4),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
       
            categoryCountLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            categoryCountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
        ])
        
        return view
    }
    
    func createStackView(axis: NSLayoutConstraint.Axis) -> UIStackView {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = axis
        sv.distribution = .fillEqually
        sv.spacing = 6
        
        return sv
    }
}
