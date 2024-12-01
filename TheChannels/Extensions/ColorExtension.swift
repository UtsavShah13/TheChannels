//
//  TheChannels
//
//  Created by Utsav on 29/11/24.
//

import Foundation
import UIKit

extension UIColor {
    static func colorFromHex(_ hex: String, alpha: CGFloat = 1.0) -> UIColor? {
        // Clean the hex string
        var cleanedHexString = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        if cleanedHexString.hasPrefix("#") {
            cleanedHexString.removeFirst()
        }

        // Ensure valid length
        guard cleanedHexString.count == 6 || cleanedHexString.count == 8 else {
            return nil
        }

        // Convert hex string to UInt32
        var hexValue: UInt32 = 0
        Scanner(string: cleanedHexString).scanHexInt32(&hexValue)

        // Extract color components
        let red = CGFloat((hexValue >> 16) & 0xFF) / 255.0
        let green = CGFloat((hexValue >> 8) & 0xFF) / 255.0
        let blue = CGFloat(hexValue & 0xFF) / 255.0

        // Extract alpha if provided in the hex string
        let extractedAlpha: CGFloat
        if cleanedHexString.count == 8 {
            extractedAlpha = CGFloat((hexValue >> 24) & 0xFF) / 255.0
        } else {
            extractedAlpha = alpha
        }

        return UIColor(red: red, green: green, blue: blue, alpha: extractedAlpha)
    }
}
extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}
