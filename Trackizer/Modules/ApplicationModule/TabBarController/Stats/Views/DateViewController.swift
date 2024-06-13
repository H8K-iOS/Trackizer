import UIKit

final class DateViewController: UIViewController {
    //MARK: Constants
    private let datePicker = UIDatePicker()
    private let doneButton = UIButton()
    
    //MARK: Variables
    var onDateRangeSelected: ((Date, Date) -> Void)?
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = GrayColors.gray50.OWColor
    }
    //MARK: Methods
    
    
}

//MARK: - Extensions
private extension DateViewController {
    
}
