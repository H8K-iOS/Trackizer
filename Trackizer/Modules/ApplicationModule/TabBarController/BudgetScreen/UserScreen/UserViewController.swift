import UIKit

final class UserViewController: UIViewController {
    // MARK: - Constants
    private let logoutButton = UIButton()
    private let accountTitleLabel = UILabel()
    private let usernameLabel = UILabel()
    private let currencyLabel = UILabel()
    private let currencySegmentedControl = UISegmentedControl(items: CurrencySymbol.allCases.map { $0.rawValue })
    
    private let authService = AuthService.shared
    private let currencyManager = CurrencyManager.shared
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.view.backgroundColor = GrayColors.gray70.OWColor
        setupUI()
        setupNavigationBar()
        
        currencySegmentedControl.selectedSegmentIndex = CurrencySymbol.allCases.firstIndex(of: currencyManager.currentSymbol) ?? 0
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Methods
    @objc private func logoutButtonTapped() {
        let alertController = UIAlertController(title: "Log out", message: "Are you sure you want to log out?", preferredStyle: .alert)
        
        let logout = UIAlertAction(title: "Log out", style: .destructive) { _ in
            self.signOut()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(logout)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
    
    @objc private func closeButtonTapped() {
        self.dismiss(animated: true)
    }
    
    @objc private func currencyChanged() {
        let selectedIndex = currencySegmentedControl.selectedSegmentIndex
        let selectedSymbol = CurrencySymbol.allCases[selectedIndex]
        currencyManager.currentSymbol = selectedSymbol
    }
    
    private func signOut() {
        authService.signOut { [weak self] error in
            if let error {
                AlertManager.showLogoutErrorAlert(on: self ?? UIViewController(), with: error)
            } else {
                if let sceneDelegate = self?.view.window?.windowScene?.delegate as? SceneDelegate {
                    sceneDelegate.checkAunthentification()
                }
            }
        }
    }
}

// MARK: - Extensions
private extension UserViewController {
    func setupUI() {
        self.view.addSubview(logoutButton)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.setTitle("Log out", for: .normal)
        logoutButton.setImage(UIImage(systemName: "figure.run"), for: .normal)
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        logoutButton.tintColor = .systemGray
        
        self.view.addSubview(accountTitleLabel)
        accountTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        accountTitleLabel.font = .systemFont(ofSize: 34, weight: .heavy)
        accountTitleLabel.text = "My account"
        accountTitleLabel.textColor = .white
        accountTitleLabel.textAlignment = .left
        accountTitleLabel.tintColor = .systemGray
        
        self.view.addSubview(currencyLabel)
        currencyLabel.translatesAutoresizingMaskIntoConstraints = false
        currencyLabel.font = .systemFont(ofSize: 22, weight: .medium)
        currencyLabel.text = "Select currency:"
        currencyLabel.textColor = .white
        currencyLabel.textAlignment = .left
        
        self.view.addSubview(usernameLabel)
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(currencySegmentedControl)
        currencySegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        currencySegmentedControl.addTarget(self, action: #selector(currencyChanged), for: .valueChanged)
        
        NSLayoutConstraint.activate([
            accountTitleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 16),
            accountTitleLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            
            logoutButton.topAnchor.constraint(equalTo: currencyLabel.bottomAnchor, constant: 16),
            logoutButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            usernameLabel.topAnchor.constraint(equalTo: accountTitleLabel.bottomAnchor, constant: 16),
            usernameLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            
            currencyLabel.topAnchor.constraint(equalTo: accountTitleLabel.bottomAnchor, constant: 26),
            currencyLabel.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            
            currencySegmentedControl.topAnchor.constraint(equalTo: accountTitleLabel.bottomAnchor, constant: 26),
            currencySegmentedControl.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -16),
        ])
    }
    
    func setupNavigationBar() {
        let closeButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "xmark"),
            style: .plain,
            target: self,
            action: #selector(closeButtonTapped)
        )
        closeButtonItem.tintColor = .systemGray
        
        self.navigationItem.rightBarButtonItem = closeButtonItem
    }
}
