import FirebaseFirestore

struct IncomeModel {
    let incomeSource: String
    let date: String
    let amount: Double
    
    init(incomeSource: String, date: String, amount: Double) {
        self.incomeSource = incomeSource
        self.date = date
        self.amount = amount
    }
    
    init?(document: DocumentSnapshot) {
        let data = document.data()
        let incomeSource = data?["incomeSource"] as? String ?? ""
        let amount = data?["amount"] as? Double ?? 0.0
        let date = data?["date"] as? String ?? ""
        
        self.init(incomeSource: incomeSource, date: date, amount: amount)
    }
    
    
}
