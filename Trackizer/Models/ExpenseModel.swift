import Foundation
import FirebaseFirestore

struct ExpenseModel {
    let categoryName: String
    let expenseID: String
    let spendsName: String
    let date: Date
    let amount: Double
    
    init(categoryName: String, expenseID: String, spendsName: String, date: Date, amount: Double) {
        self.categoryName = categoryName
        self.expenseID = expenseID
        self.spendsName = spendsName
        self.date = date
        self.amount = amount
    }
    
    init?(document: DocumentSnapshot) {
        let data = document.data()
        let categoryName = data?["categoryName"] as? String ?? ""
        let expenseID = data?["expenseID"] as? String ?? ""
        let spendsName = data?["spendsName"] as? String ?? ""
        let moneySpent = data?["moneySpent"] as? Double ?? 0.0
        
        let timestamp = data?["date"] as? Timestamp
        let date = timestamp?.dateValue() ?? Date()
        
        self.init(categoryName: categoryName, expenseID: expenseID, spendsName: spendsName, date: date, amount: moneySpent)
    }
    
    func formattedDate() -> String {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "MMM dd, yyyy HH:mm"
           return dateFormatter.string(from: date)
       }
}
