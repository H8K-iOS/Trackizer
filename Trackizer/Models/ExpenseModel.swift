import Foundation
import FirebaseFirestore

struct ExpenseModel {
    let categoryName: String
    let spendsName: String
    let amount: Double
    
    init(categoryName: String, spendsName: String, amount: Double) {
        self.categoryName = categoryName
        self.spendsName = spendsName
        self.amount = amount
    }
    
    init?(document: DocumentSnapshot) {
        let data = document.data()
        let categoryName = data?["categoryName"] as? String ?? ""
        let spendsName = data?["spendsName"] as? String ?? ""
        let moneySpent = data?["moneySpent"] as? Double ?? 0.0
        
        self.init(categoryName: categoryName, spendsName: spendsName, amount: moneySpent)
    }
}
