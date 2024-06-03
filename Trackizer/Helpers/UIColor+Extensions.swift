import UIKit

enum GrayColors: Int {
    
    case gray100, gray80, gray70, gray60, gray50, gray40, gray30, gray20, gray10, white
    
    var OWColor: UIColor {
        switch self {
            //GraySection
        case .gray100:
            return #colorLiteral(red: 0.05162274837, green: 0.05230627209, blue: 0.07106862217, alpha: 1)
        case .gray80:
            return #colorLiteral(red: 0.1072267219, green: 0.1082133129, blue: 0.1354416311, alpha: 1)
        case .gray70:
            return #colorLiteral(red: 0.2080399692, green: 0.2099102139, blue: 0.2606674135, alpha: 1)
        case .gray60:
            return #colorLiteral(red: 0.3060910106, green: 0.3044097424, blue: 0.3791401386, alpha: 1)
        case .gray50:
            return #colorLiteral(red: 0.3998924792, green: 0.3996608257, blue: 0.5030135512, alpha: 1)
        case .gray40:
            return #colorLiteral(red: 0.5144364834, green: 0.5141195059, blue: 0.610948503, alpha: 1)
        case .gray30:
            return #colorLiteral(red: 0.6360314488, green: 0.6350405216, blue: 0.7098141313, alpha: 1)
        case .gray20:
            return #colorLiteral(red: 0.757612884, green: 0.7558475137, blue: 0.8045553565, alpha: 1)
        case .gray10:
            return #colorLiteral(red: 0.879858315, green: 0.8774282336, blue: 0.9023428559, alpha: 1)
        case .white:
            return #colorLiteral(red: 1, green: 0.9999999404, blue: 1, alpha: 1)
        }
    }
}

enum PrimarySection: Int {
    case  primary100, primary500, primary20, primary10, primary05, primary0
    
    var OWColor: UIColor {
        switch self {
            //MARK: PrimarySection
        case .primary100:
            return #colorLiteral(red: 0.3683633208, green: 0.1956099868, blue: 0.9606608748, alpha: 1)
        case .primary500:
            return #colorLiteral(red: 0.4668670893, green: 0.2092481256, blue: 1, alpha: 1)
        case .primary20:
            return #colorLiteral(red: 0.5734605789, green: 0.3065589666, blue: 1, alpha: 1)
        case .primary10:
            return #colorLiteral(red: 0.6801425815, green: 0.4821387529, blue: 1, alpha: 1)
        case .primary05:
            return #colorLiteral(red: 0.788181901, green: 0.6553102732, blue: 1, alpha: 1)
        case .primary0:
            return #colorLiteral(red: 0.8945872188, green: 0.8290757537, blue: 1, alpha: 1)
        }
    }
}

enum AccentPrimarySection: Int {
    case accentP100, accentP50, accentP0
    
    var OWColor: UIColor {
        //MARK: AccentPrimarySection
        switch self {
        case .accentP100:
            return #colorLiteral(red: 0.9996259809, green: 0.4729316235, blue: 0.4015447795, alpha: 1)
        case .accentP50:
            return #colorLiteral(red: 1, green: 0.6509083509, blue: 0.5987089872, alpha: 1)
        case .accentP0:
            return #colorLiteral(red: 1, green: 0.8242250085, blue: 0.800650835, alpha: 1)
        }
    }
}

enum AccentSecondarySection: Int {
    case accentS100, accentS50
    
    var OWColor: UIColor {
        //MARK: AccentSecondarySection
        switch self {
        case .accentS100:
            return #colorLiteral(red: 0.007453168742, green: 0.9811897874, blue: 0.8509250879, alpha: 1)
        case .accentS50:
            return #colorLiteral(red: 0.4889922738, green: 0.991276443, blue: 0.9345808029, alpha: 1)
        }
    }
}



