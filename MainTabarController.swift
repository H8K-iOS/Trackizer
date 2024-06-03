import UIKit

final class MainTabarController: UITabBarController {
    //MARK: Constants
    
    
    //MARK: Variables
    
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
        drawTabBar()
    }
    //MARK: Methods
    
    
}

//MARK: - Extensions
private extension MainTabarController {
    func setupTabBar() {
        viewControllers = [generateVC(for: BudgetViewController(), title: "Spends",
                                           icon: #imageLiteral(resourceName: "Home.png")),
                           generateVC(for: ExpenseViewController(), title: "Exspense",
                                           icon: #imageLiteral(resourceName: "Budgets.png")),
                           generateVC(for: IncomeViewController(), title: "Income",
                                           icon: #imageLiteral(resourceName: "Credit Cards")),
                           generateVC(for: CalendarViewController(), title: "Calendar",
                                           icon: #imageLiteral(resourceName: "Calendar.png"))
        ]
        
    }
    
    func generateVC(for vc: UIViewController, title: String, icon: UIImage?) -> UIViewController {
        let nav = UINavigationController(rootViewController: vc)
        vc.tabBarItem.image = icon
        vc.tabBarItem.title = title
        return nav
    }
    
    private func drawTabBar() {
        tabBar.backgroundImage = UIImage()
        tabBar.backgroundColor = .clear
        tabBar.tintColor = AccentPrimarySection.accentP50.OWColor
        let posX: CGFloat = 10
        let posY: CGFloat = 14
        let width = tabBar.bounds.width - posX*2
        let height = tabBar.bounds.height + posY*2
        
        let layer = CAShapeLayer()
        let bezierPath = UIBezierPath(roundedRect: CGRect(x: posX,
                                                          y: tabBar.bounds.minY - posY,
                                                          width: width, height: height
                                                         ),
                                      cornerRadius: height/2)
        
        
        layer.path = bezierPath.cgPath
        layer.fillColor = GrayColors.gray100.OWColor.withAlphaComponent(0.8).cgColor
        
        tabBar.layer.insertSublayer(layer, at: 0)
        tabBar.itemWidth = width / 5
        
    }
}
