import UIKit
import WebKit

final class WebViewerController: UIViewController {
    //MARK: Constants
    private let urlString: String
    private let webView = WKWebView()
    
    //MARK: Variables
    
    
    //MARK: Lifecycle
    init(with urlString: String) {
        self.urlString = urlString
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .currentContext
    }
    required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        check()
    }
    //MARK: Methods
    private func check() {
        guard let url = URL(string: self.urlString) else { self.dismiss(animated: true); return }
        self.webView.load(URLRequest(url: url))
    }
    @objc private func doneButtonTapped() {
        self.dismiss(animated: true)
    }
}

//MARK: - Extensions
private extension WebViewerController {
    private func setupUI() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "done", style: .done, target: self, action: #selector(doneButtonTapped))
        
        
        self.view.addSubview(webView)
        self.webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.webView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.webView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.webView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.webView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
    }
}
