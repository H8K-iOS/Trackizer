import Foundation
#if canImport(AppKit)
import AppKit
#endif
#if canImport(UIKit)
import UIKit
#endif
#if canImport(SwiftUI)
import SwiftUI
#endif
#if canImport(DeveloperToolsSupport)
import DeveloperToolsSupport
#endif

#if SWIFT_PACKAGE
private let resourceBundle = Foundation.Bundle.module
#else
private class ResourceBundleClass {}
private let resourceBundle = Foundation.Bundle(for: ResourceBundleClass.self)
#endif

// MARK: - Color Symbols -

@available(iOS 11.0, macOS 10.13, tvOS 11.0, *)
extension ColorResource {

}

// MARK: - Image Symbols -

@available(iOS 11.0, macOS 10.7, tvOS 11.0, *)
extension ImageResource {

    /// The "App icon" asset catalog image resource.
    static let appIcon = ImageResource(name: "App icon", bundle: resourceBundle)

    /// The "Auto & Transport" asset catalog image resource.
    static let autoTransport = ImageResource(name: "Auto & Transport", bundle: resourceBundle)

    /// The "Budgets" asset catalog image resource.
    static let budgets = ImageResource(name: "Budgets", bundle: resourceBundle)

    /// The "Calendar" asset catalog image resource.
    static let calendar = ImageResource(name: "Calendar", bundle: resourceBundle)

    /// The "Chart" asset catalog image resource.
    static let chart = ImageResource(name: "Chart", bundle: resourceBundle)

    /// The "Credit Cards" asset catalog image resource.
    static let creditCards = ImageResource(name: "Credit Cards", bundle: resourceBundle)

    /// The "Entertainment" asset catalog image resource.
    static let entertainment = ImageResource(name: "Entertainment", bundle: resourceBundle)

    /// The "FaceID" asset catalog image resource.
    static let faceID = ImageResource(name: "FaceID", bundle: resourceBundle)

    /// The "Font" asset catalog image resource.
    static let font = ImageResource(name: "Font", bundle: resourceBundle)

    /// The "HBO GO Logo" asset catalog image resource.
    static let hboGOLogo = ImageResource(name: "HBO GO Logo", bundle: resourceBundle)

    /// The "Home" asset catalog image resource.
    static let home = ImageResource(name: "Home", bundle: resourceBundle)

    /// The "Image" asset catalog image resource.
    static let image = ImageResource(name: "Image", bundle: resourceBundle)

    /// The "Light theme" asset catalog image resource.
    static let lightTheme = ImageResource(name: "Light theme", bundle: resourceBundle)

    /// The "Minus" asset catalog image resource.
    static let minus = ImageResource(name: "Minus", bundle: resourceBundle)

    /// The "Money" asset catalog image resource.
    static let money = ImageResource(name: "Money", bundle: resourceBundle)

    /// The "Netflix Logo" asset catalog image resource.
    static let netflixLogo = ImageResource(name: "Netflix Logo", bundle: resourceBundle)

    /// The "OneDrive Logo" asset catalog image resource.
    static let oneDriveLogo = ImageResource(name: "OneDrive Logo", bundle: resourceBundle)

    /// The "Plus" asset catalog image resource.
    static let plus = ImageResource(name: "Plus", bundle: resourceBundle)

    /// The "Security" asset catalog image resource.
    static let security = ImageResource(name: "Security", bundle: resourceBundle)

    /// The "Sorting" asset catalog image resource.
    static let sorting = ImageResource(name: "Sorting", bundle: resourceBundle)

    /// The "Spotify Logo" asset catalog image resource.
    static let spotifyLogo = ImageResource(name: "Spotify Logo", bundle: resourceBundle)

    /// The "Vector" asset catalog image resource.
    static let vector = ImageResource(name: "Vector", bundle: resourceBundle)

    /// The "Vector-1" asset catalog image resource.
    static let vector1 = ImageResource(name: "Vector-1", bundle: resourceBundle)

    /// The "WelcomeYT" asset catalog image resource.
    static let welcomeYT = ImageResource(name: "WelcomeYT", bundle: resourceBundle)

    /// The "YT Premium Lgoo" asset catalog image resource.
    static let ytPremiumLgoo = ImageResource(name: "YT Premium Lgoo", bundle: resourceBundle)

    /// The "addIcon" asset catalog image resource.
    static let addIcon = ImageResource(name: "addIcon", bundle: resourceBundle)

    /// The "appleIcon" asset catalog image resource.
    static let appleIcon = ImageResource(name: "appleIcon", bundle: resourceBundle)

    /// The "back1" asset catalog image resource.
    static let back1 = ImageResource(name: "back1", bundle: resourceBundle)

    /// The "back2" asset catalog image resource.
    static let back2 = ImageResource(name: "back2", bundle: resourceBundle)

    /// The "facebookIcon" asset catalog image resource.
    static let facebookIcon = ImageResource(name: "facebookIcon", bundle: resourceBundle)

    /// The "googleIcon" asset catalog image resource.
    static let googleIcon = ImageResource(name: "googleIcon", bundle: resourceBundle)

    /// The "iCloud" asset catalog image resource.
    static let iCloud = ImageResource(name: "iCloud", bundle: resourceBundle)

    /// The "idkwhatisthis" asset catalog image resource.
    static let idkwhatisthis = ImageResource(name: "idkwhatisthis", bundle: resourceBundle)

    /// The "logo" asset catalog image resource.
    static let logo = ImageResource(name: "logo", bundle: resourceBundle)

    /// The "trackiezer" asset catalog image resource.
    static let trackiezer = ImageResource(name: "trackiezer", bundle: resourceBundle)

    /// The "welcomeNetflix" asset catalog image resource.
    static let welcomeNetflix = ImageResource(name: "welcomeNetflix", bundle: resourceBundle)

    /// The "welcomeOnedrive" asset catalog image resource.
    static let welcomeOnedrive = ImageResource(name: "welcomeOnedrive", bundle: resourceBundle)

    /// The "welcomeSpotify" asset catalog image resource.
    static let welcomeSpotify = ImageResource(name: "welcomeSpotify", bundle: resourceBundle)

}

// MARK: - Color Symbol Extensions -

#if canImport(AppKit)
@available(macOS 10.13, *)
@available(macCatalyst, unavailable)
extension AppKit.NSColor {

}
#endif

#if canImport(UIKit)
@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIColor {

}
#endif

#if canImport(SwiftUI)
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.Color {

}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.ShapeStyle where Self == SwiftUI.Color {

}
#endif

// MARK: - Image Symbol Extensions -

#if canImport(AppKit)
@available(macOS 10.7, *)
@available(macCatalyst, unavailable)
extension AppKit.NSImage {

    /// The "App icon" asset catalog image.
    static var appIcon: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIcon)
#else
        .init()
#endif
    }

    /// The "Auto & Transport" asset catalog image.
    static var autoTransport: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .autoTransport)
#else
        .init()
#endif
    }

    /// The "Budgets" asset catalog image.
    static var budgets: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .budgets)
#else
        .init()
#endif
    }

    /// The "Calendar" asset catalog image.
    static var calendar: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .calendar)
#else
        .init()
#endif
    }

    /// The "Chart" asset catalog image.
    static var chart: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .chart)
#else
        .init()
#endif
    }

    /// The "Credit Cards" asset catalog image.
    static var creditCards: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .creditCards)
#else
        .init()
#endif
    }

    /// The "Entertainment" asset catalog image.
    static var entertainment: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .entertainment)
#else
        .init()
#endif
    }

    /// The "FaceID" asset catalog image.
    static var faceID: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .faceID)
#else
        .init()
#endif
    }

    /// The "Font" asset catalog image.
    static var font: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .font)
#else
        .init()
#endif
    }

    /// The "HBO GO Logo" asset catalog image.
    static var hboGOLogo: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .hboGOLogo)
#else
        .init()
#endif
    }

    /// The "Home" asset catalog image.
    static var home: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .home)
#else
        .init()
#endif
    }

    /// The "Image" asset catalog image.
    static var image: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .image)
#else
        .init()
#endif
    }

    /// The "Light theme" asset catalog image.
    static var lightTheme: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .lightTheme)
#else
        .init()
#endif
    }

    /// The "Minus" asset catalog image.
    static var minus: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .minus)
#else
        .init()
#endif
    }

    /// The "Money" asset catalog image.
    static var money: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .money)
#else
        .init()
#endif
    }

    /// The "Netflix Logo" asset catalog image.
    static var netflixLogo: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .netflixLogo)
#else
        .init()
#endif
    }

    /// The "OneDrive Logo" asset catalog image.
    static var oneDriveLogo: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .oneDriveLogo)
#else
        .init()
#endif
    }

    /// The "Plus" asset catalog image.
    static var plus: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .plus)
#else
        .init()
#endif
    }

    /// The "Security" asset catalog image.
    static var security: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .security)
#else
        .init()
#endif
    }

    /// The "Sorting" asset catalog image.
    static var sorting: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .sorting)
#else
        .init()
#endif
    }

    /// The "Spotify Logo" asset catalog image.
    static var spotifyLogo: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .spotifyLogo)
#else
        .init()
#endif
    }

    /// The "Vector" asset catalog image.
    static var vector: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .vector)
#else
        .init()
#endif
    }

    /// The "Vector-1" asset catalog image.
    static var vector1: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .vector1)
#else
        .init()
#endif
    }

    /// The "WelcomeYT" asset catalog image.
    static var welcomeYT: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .welcomeYT)
#else
        .init()
#endif
    }

    /// The "YT Premium Lgoo" asset catalog image.
    static var ytPremiumLgoo: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .ytPremiumLgoo)
#else
        .init()
#endif
    }

    /// The "addIcon" asset catalog image.
    static var addIcon: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .addIcon)
#else
        .init()
#endif
    }

    /// The "appleIcon" asset catalog image.
    static var appleIcon: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appleIcon)
#else
        .init()
#endif
    }

    /// The "back1" asset catalog image.
    static var back1: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .back1)
#else
        .init()
#endif
    }

    /// The "back2" asset catalog image.
    static var back2: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .back2)
#else
        .init()
#endif
    }

    /// The "facebookIcon" asset catalog image.
    static var facebookIcon: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .facebookIcon)
#else
        .init()
#endif
    }

    /// The "googleIcon" asset catalog image.
    static var googleIcon: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .googleIcon)
#else
        .init()
#endif
    }

    /// The "iCloud" asset catalog image.
    static var iCloud: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .iCloud)
#else
        .init()
#endif
    }

    /// The "idkwhatisthis" asset catalog image.
    static var idkwhatisthis: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .idkwhatisthis)
#else
        .init()
#endif
    }

    /// The "logo" asset catalog image.
    static var logo: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .logo)
#else
        .init()
#endif
    }

    /// The "trackiezer" asset catalog image.
    static var trackiezer: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .trackiezer)
#else
        .init()
#endif
    }

    /// The "welcomeNetflix" asset catalog image.
    static var welcomeNetflix: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .welcomeNetflix)
#else
        .init()
#endif
    }

    /// The "welcomeOnedrive" asset catalog image.
    static var welcomeOnedrive: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .welcomeOnedrive)
#else
        .init()
#endif
    }

    /// The "welcomeSpotify" asset catalog image.
    static var welcomeSpotify: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .welcomeSpotify)
#else
        .init()
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIImage {

    /// The "App icon" asset catalog image.
    static var appIcon: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIcon)
#else
        .init()
#endif
    }

    /// The "Auto & Transport" asset catalog image.
    static var autoTransport: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .autoTransport)
#else
        .init()
#endif
    }

    /// The "Budgets" asset catalog image.
    static var budgets: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .budgets)
#else
        .init()
#endif
    }

    /// The "Calendar" asset catalog image.
    static var calendar: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .calendar)
#else
        .init()
#endif
    }

    /// The "Chart" asset catalog image.
    static var chart: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .chart)
#else
        .init()
#endif
    }

    /// The "Credit Cards" asset catalog image.
    static var creditCards: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .creditCards)
#else
        .init()
#endif
    }

    /// The "Entertainment" asset catalog image.
    static var entertainment: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .entertainment)
#else
        .init()
#endif
    }

    /// The "FaceID" asset catalog image.
    static var faceID: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .faceID)
#else
        .init()
#endif
    }

    /// The "Font" asset catalog image.
    static var font: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .font)
#else
        .init()
#endif
    }

    /// The "HBO GO Logo" asset catalog image.
    static var hboGOLogo: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .hboGOLogo)
#else
        .init()
#endif
    }

    /// The "Home" asset catalog image.
    static var home: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .home)
#else
        .init()
#endif
    }

    /// The "Image" asset catalog image.
    static var image: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .image)
#else
        .init()
#endif
    }

    /// The "Light theme" asset catalog image.
    static var lightTheme: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .lightTheme)
#else
        .init()
#endif
    }

    /// The "Minus" asset catalog image.
    static var minus: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .minus)
#else
        .init()
#endif
    }

    /// The "Money" asset catalog image.
    static var money: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .money)
#else
        .init()
#endif
    }

    /// The "Netflix Logo" asset catalog image.
    static var netflixLogo: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .netflixLogo)
#else
        .init()
#endif
    }

    /// The "OneDrive Logo" asset catalog image.
    static var oneDriveLogo: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .oneDriveLogo)
#else
        .init()
#endif
    }

    /// The "Plus" asset catalog image.
    static var plus: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .plus)
#else
        .init()
#endif
    }

    /// The "Security" asset catalog image.
    static var security: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .security)
#else
        .init()
#endif
    }

    /// The "Sorting" asset catalog image.
    static var sorting: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .sorting)
#else
        .init()
#endif
    }

    /// The "Spotify Logo" asset catalog image.
    static var spotifyLogo: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .spotifyLogo)
#else
        .init()
#endif
    }

    /// The "Vector" asset catalog image.
    static var vector: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .vector)
#else
        .init()
#endif
    }

    /// The "Vector-1" asset catalog image.
    static var vector1: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .vector1)
#else
        .init()
#endif
    }

    /// The "WelcomeYT" asset catalog image.
    static var welcomeYT: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .welcomeYT)
#else
        .init()
#endif
    }

    /// The "YT Premium Lgoo" asset catalog image.
    static var ytPremiumLgoo: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .ytPremiumLgoo)
#else
        .init()
#endif
    }

    /// The "addIcon" asset catalog image.
    static var addIcon: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .addIcon)
#else
        .init()
#endif
    }

    /// The "appleIcon" asset catalog image.
    static var appleIcon: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appleIcon)
#else
        .init()
#endif
    }

    /// The "back1" asset catalog image.
    static var back1: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .back1)
#else
        .init()
#endif
    }

    /// The "back2" asset catalog image.
    static var back2: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .back2)
#else
        .init()
#endif
    }

    /// The "facebookIcon" asset catalog image.
    static var facebookIcon: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .facebookIcon)
#else
        .init()
#endif
    }

    /// The "googleIcon" asset catalog image.
    static var googleIcon: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .googleIcon)
#else
        .init()
#endif
    }

    /// The "iCloud" asset catalog image.
    static var iCloud: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .iCloud)
#else
        .init()
#endif
    }

    /// The "idkwhatisthis" asset catalog image.
    static var idkwhatisthis: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .idkwhatisthis)
#else
        .init()
#endif
    }

    /// The "logo" asset catalog image.
    static var logo: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .logo)
#else
        .init()
#endif
    }

    /// The "trackiezer" asset catalog image.
    static var trackiezer: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .trackiezer)
#else
        .init()
#endif
    }

    /// The "welcomeNetflix" asset catalog image.
    static var welcomeNetflix: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .welcomeNetflix)
#else
        .init()
#endif
    }

    /// The "welcomeOnedrive" asset catalog image.
    static var welcomeOnedrive: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .welcomeOnedrive)
#else
        .init()
#endif
    }

    /// The "welcomeSpotify" asset catalog image.
    static var welcomeSpotify: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .welcomeSpotify)
#else
        .init()
#endif
    }

}
#endif

// MARK: - Thinnable Asset Support -

@available(iOS 11.0, macOS 10.13, tvOS 11.0, *)
@available(watchOS, unavailable)
extension ColorResource {

    private init?(thinnableName: String, bundle: Bundle) {
#if canImport(AppKit) && os(macOS)
        if AppKit.NSColor(named: NSColor.Name(thinnableName), bundle: bundle) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#elseif canImport(UIKit) && !os(watchOS)
        if UIKit.UIColor(named: thinnableName, in: bundle, compatibleWith: nil) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}

#if canImport(UIKit)
@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIColor {

    private convenience init?(thinnableResource: ColorResource?) {
#if !os(watchOS)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

#if canImport(SwiftUI)
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.Color {

    private init?(thinnableResource: ColorResource?) {
        if let resource = thinnableResource {
            self.init(resource)
        } else {
            return nil
        }
    }

}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.ShapeStyle where Self == SwiftUI.Color {

    private init?(thinnableResource: ColorResource?) {
        if let resource = thinnableResource {
            self.init(resource)
        } else {
            return nil
        }
    }

}
#endif

@available(iOS 11.0, macOS 10.7, tvOS 11.0, *)
@available(watchOS, unavailable)
extension ImageResource {

    private init?(thinnableName: String, bundle: Bundle) {
#if canImport(AppKit) && os(macOS)
        if bundle.image(forResource: NSImage.Name(thinnableName)) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#elseif canImport(UIKit) && !os(watchOS)
        if UIKit.UIImage(named: thinnableName, in: bundle, compatibleWith: nil) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}

#if canImport(AppKit)
@available(macOS 10.7, *)
@available(macCatalyst, unavailable)
extension AppKit.NSImage {

    private convenience init?(thinnableResource: ImageResource?) {
#if !targetEnvironment(macCatalyst)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIImage {

    private convenience init?(thinnableResource: ImageResource?) {
#if !os(watchOS)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

// MARK: - Backwards Deployment Support -

/// A color resource.
struct ColorResource: Hashable {

    /// An asset catalog color resource name.
    fileprivate let name: String

    /// An asset catalog color resource bundle.
    fileprivate let bundle: Bundle

    /// Initialize a `ColorResource` with `name` and `bundle`.
    init(name: String, bundle: Bundle) {
        self.name = name
        self.bundle = bundle
    }

}

/// An image resource.
struct ImageResource: Hashable {

    /// An asset catalog image resource name.
    fileprivate let name: String

    /// An asset catalog image resource bundle.
    fileprivate let bundle: Bundle

    /// Initialize an `ImageResource` with `name` and `bundle`.
    init(name: String, bundle: Bundle) {
        self.name = name
        self.bundle = bundle
    }

}

#if canImport(AppKit)
@available(macOS 10.13, *)
@available(macCatalyst, unavailable)
extension AppKit.NSColor {

    /// Initialize a `NSColor` with a color resource.
    convenience init(resource: ColorResource) {
        self.init(named: NSColor.Name(resource.name), bundle: resource.bundle)!
    }

}

protocol _ACResourceInitProtocol {}
extension AppKit.NSImage: _ACResourceInitProtocol {}

@available(macOS 10.7, *)
@available(macCatalyst, unavailable)
extension _ACResourceInitProtocol {

    /// Initialize a `NSImage` with an image resource.
    init(resource: ImageResource) {
        self = resource.bundle.image(forResource: NSImage.Name(resource.name))! as! Self
    }

}
#endif

#if canImport(UIKit)
@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIColor {

    /// Initialize a `UIColor` with a color resource.
    convenience init(resource: ColorResource) {
#if !os(watchOS)
        self.init(named: resource.name, in: resource.bundle, compatibleWith: nil)!
#else
        self.init()
#endif
    }

}

@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIImage {

    /// Initialize a `UIImage` with an image resource.
    convenience init(resource: ImageResource) {
#if !os(watchOS)
        self.init(named: resource.name, in: resource.bundle, compatibleWith: nil)!
#else
        self.init()
#endif
    }

}
#endif

#if canImport(SwiftUI)
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.Color {

    /// Initialize a `Color` with a color resource.
    init(_ resource: ColorResource) {
        self.init(resource.name, bundle: resource.bundle)
    }

}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.Image {

    /// Initialize an `Image` with an image resource.
    init(_ resource: ImageResource) {
        self.init(resource.name, bundle: resource.bundle)
    }

}
#endif