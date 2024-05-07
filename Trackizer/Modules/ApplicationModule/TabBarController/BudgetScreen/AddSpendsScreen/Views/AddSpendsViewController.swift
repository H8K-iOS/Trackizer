import UIKit

final class AddSpendsViewController: UIViewController {
    //MARK: Constants
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
    
    //MARK: Variables
    init() {
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overCurrentContext
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .clear
        setUI()
    }
    //MARK: Methods
    
    
}

//MARK: - Extensions
private extension AddSpendsViewController {
    func setUI() {
        self.view.addSubview(blurContaienr)
        blurContaienr.effect = blurEffect
        
        NSLayoutConstraint.activate([
        
            blurContaienr.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            blurContaienr.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            
            blurContaienr.widthAnchor.constraint(equalToConstant: 330),
            blurContaienr.heightAnchor.constraint(equalToConstant: 500),
        ])
        
    }
}
