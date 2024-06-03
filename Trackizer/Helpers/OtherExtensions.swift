import Foundation
import UIKit

extension FloatingPoint {
    func rounded(toPlaces places: Int) -> Self {
        let divisor = Self(Int(pow(10.0, Double(places))))
        return (self * divisor).rounded() / divisor
    }
}

struct Constants {
    public static let screenHeight = UIScreen.main.bounds.height
}
