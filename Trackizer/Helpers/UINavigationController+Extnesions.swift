import UIKit

extension UINavigationBar {
    static func setupNavBar() {
        let appearance = UINavigationBar.appearance()
        appearance.barTintColor = GrayColors.white.OWColor
        appearance.tintColor = GrayColors.gray70.OWColor
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: GrayColors.white.OWColor]
        
        appearance.prefersLargeTitles = true
    }
}


