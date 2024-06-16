import UIKit

enum CurrencySymbol: String, CaseIterable {
    case hryvnia = "₴"
    case usd = "$"
    case euro = "€"
    
    static func from(rawValue: String) -> CurrencySymbol? {
        return CurrencySymbol.allCases.first {$0.rawValue == rawValue}
    }
}

final class CurrencyManager {
    static let shared = CurrencyManager()
    
    private var currentCurrency: CurrencySymbol = .hryvnia {
        didSet {
            // Посылаем уведомление о изменении валюты
            NotificationCenter.default.post(name: .currencyDidChange, object: nil)
        }
    }
    
    var currentCurrencyCode: String {
        switch currentCurrency {
        case .hryvnia:
            return "UAH"
        case .usd:
            return "USD"
        case .euro:
            return "EUR"
        }
    }
    
    private let selectedCurrencyKey = "selectedCurrencySymbol"
    
    private init() {
        // Устанавливаем текущую валюту из UserDefaults
        if let storedSymbol = UserDefaults.standard.string(forKey: selectedCurrencyKey) {
            currentCurrency = CurrencySymbol(rawValue: storedSymbol) ?? .hryvnia
        }
    }
    
    var currentSymbol: CurrencySymbol {
        get {
            return currentCurrency
        }
        set {
            currentCurrency = newValue
            UserDefaults.standard.set(newValue.rawValue, forKey: selectedCurrencyKey)
        }
    }
}

extension Notification.Name {
    static let currencyDidChange = Notification.Name("currencyDidChange")
}
