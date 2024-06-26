import DGCharts

final class DateValueFormatter: AxisValueFormatter {
    private let dateFormatter = DateFormatter()
     
     init() {
         dateFormatter.dateFormat = "MMM dd"
     }
     
     func stringForValue(_ value: Double, axis: AxisBase?) -> String {
         let date = Date(timeIntervalSince1970: value)
         return dateFormatter.string(from: date)
     }
 }
