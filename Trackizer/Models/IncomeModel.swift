import FirebaseFirestore

struct IncomeModel {
    let incomeID: String
    let incomeSource: String
    let date: Date
    let amount: Double
    
    init(incomeID: String, incomeSource: String, date: Date, amount: Double) {
        self.incomeID = incomeID
        self.incomeSource = incomeSource
        self.date = date
        self.amount = amount
    }
    
    init?(document: DocumentSnapshot) {
        let data = document.data()
        let incomeID = data?["incomeID"] as? String ?? ""
        let incomeSource = data?["incomeSource"] as? String ?? ""
        let amount = data?["amount"] as? Double ?? 0.0
        
        let timestamp = data?["date"] as? Timestamp
        let date = timestamp?.dateValue() ?? Date()
        
        self.init(incomeID: incomeID, incomeSource: incomeSource, date: date, amount: amount)
    }
    
    func formattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy HH:mm"
        return dateFormatter.string(from: date)
    }
    
    func formattedDateForChart() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
}
