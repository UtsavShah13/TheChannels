//
//  TheChannels
//
//  Created by Utsav on 29/11/24.
//

import UIKit

struct ScreenSize {
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenMaxLength = max(ScreenSize.screenWidth, ScreenSize.screenHeight)
    static let screenMinLength = min(ScreenSize.screenWidth, ScreenSize.screenHeight)
}

enum ScreenInches: String, CaseIterable {
    // swiftlint:disable identifier_name
    case in3_5 // iPhone 4 (S)
    case in4 // iPhone 5 (C/S/SE)
    case in4_7 // iPhone 6/7/8
    case in5_5 // iPhone 6/7/8 Plus (S)
    case in5_6 // Iphone 12 mini
    case in5_8 // iPhone X/Xs
    case in6_1 // iPhone Xr, Pro
    case in6_5 // iPhone Xs Max, Pro max
    case unknown
}

enum ScreenSizeType {
    case small
    case medium
    case large
}

extension UIDevice {

    var screenSizeType: ScreenSizeType {
        switch UIDevice.current.screenInches {
        case .in3_5, .in4:
            return .small
        case .in4_7, .in5_5, .in5_6:
            return .medium
        case .in5_8, .in6_1, .in6_5:
            return .large
        default:
            return .large
        }
    }
    
    enum ScreenType: String {
        case iPhone4 = "iPhone 4 or iPhone 4S"
        case iPhones5 = "iPhone 5, iPhone 5s, iPhone 5c or iPhone SE"
        case iPhones6 = "iPhone SE (2nd Generation), iPhone 6, iPhone 6S, iPhone 7 or iPhone 8"
        case iPhones6Plus = "iPhone 6 Plus, iPhone 6S Plus, iPhone 7 Plus or iPhone 8 Plus"
        case iPhoneX = "iPhone X or XS, 11 Pro"
        case iPhoneXR = "iPhone XR, 11"
        case iPhone12 = "iPhone 12, iPhone 12 pro"
        case iPhoneXSMax = "iPhone XS Max, iPhone 11 Pro Max"
        case iPhone12ProMax = "iPhone 12 Pro Max"
        case unknown
    }
    
    var screenType: ScreenType {
        switch UIScreen.main.nativeBounds.height {
        case 960:
            return .iPhone4
        case 1136:
            return .iPhones5
        case 1334:
            return .iPhones6
        case 1920, 2208:
            return .iPhones6Plus
        case 2436:
            return .iPhoneX
        case 2532:
            return .iPhone12
        case 1792:
            return .iPhoneXR
        case 2688:
            return .iPhoneXSMax
        case 2778:
            return .iPhone12ProMax
        default:
            return .unknown
        }
    }
    
    var screenInches: ScreenInches {
        switch ScreenSize.screenHeight {
        case 480:
            return .in3_5
        case 568:
            return .in4
        case 667:
            return .in4_7
        case 736:
            return .in5_5
        case 768:
            return .in5_6
        case 812:
            return .in5_8
        case 896:
            return .in6_1
        default:
            return .in6_5
        }
    }
    
    var hasNotch: Bool {
        let bottom = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
}

extension UIViewController {
    class func setUIInterfaceOrientation(_ value: UIInterfaceOrientation) {
        UIDevice.current.setValue(value.rawValue, forKey: "orientation")
    }
}
