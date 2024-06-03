import Foundation
import FirebaseFirestore
import UIKit




struct BudgetModel {
    let categoryName: String
    let categoryTotalValue: Double
    let categorySpent: Double
    let leftToSpend: Double
    let color: UIColor
    let icon: UIImage
    
    init(categoryName: String, categoryTotalValue: Double, categorySpent: Double, leftToSpend: Double, color: UIColor, icon: UIImage) {
        self.categoryName = categoryName
        self.categoryTotalValue = categoryTotalValue
        self.categorySpent = categorySpent
        self.leftToSpend = leftToSpend
        self.color = color
        self.icon = icon
    }
    
    init?(document: DocumentSnapshot) {
        let data = document.data()
        let categoryName = data?["categoryName"] as? String ?? ""
        let categoryTotalValue = data?["total"] as? Double ?? 0.0
        let categorySpent = data?["moneySpent"] as? Double ?? 0.0
        let leftToSpend = categoryTotalValue - categorySpent
        
        let color: UIColor
        let icon: UIImage
        switch categoryName {
        case "Security":
            color = AccentPrimarySection.accentP100.OWColor
            icon = #imageLiteral(resourceName: "Security.png")
        case "Auto":
            color = AccentSecondarySection.accentS50.OWColor
            icon = #imageLiteral(resourceName: "Auto & Transport.png")
            
        case "Entertainment":
            color = PrimarySection.primary100.OWColor
            icon = #imageLiteral(resourceName: "Entertainment.png")
        
        case "Medecine":
            color = PrimarySection.primary10.OWColor
            icon = #imageLiteral(resourceName: "Entertainment.png")
       
        case "Restaurants":
            color = AccentPrimarySection.accentP0.OWColor
            icon = #imageLiteral(resourceName: "Entertainment.png")
        
        case "Grocceries":
            color = UIColor.green.withAlphaComponent(0.8)
            icon = #imageLiteral(resourceName: "Entertainment.png")
       
        case "Taxi":
            color = UIColor.yellow.withAlphaComponent(0.8)
            icon = #imageLiteral(resourceName: "Entertainment.png")
        
        case "Flowers":
            color = UIColor.systemPink.withAlphaComponent(0.8)
            icon = #imageLiteral(resourceName: "Entertainment.png")
            
        case "Personal":
            color = UIColor.systemBrown.withAlphaComponent(0.8)
            icon = #imageLiteral(resourceName: "Entertainment.png")
            
        case "Fashion":
            color = UIColor.red.withAlphaComponent(0.8)
            icon = #imageLiteral(resourceName: "Entertainment.png")
        default:
            color = .white
            icon = UIImage()
        }
        self.init(categoryName: categoryName, categoryTotalValue: categoryTotalValue, categorySpent: categorySpent, leftToSpend: leftToSpend, color: color, icon: icon)
    }
}

