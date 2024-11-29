//
//  TheChannels
//
//  Created by Utsav on 29/11/24.
//

import Foundation
import UIKit

extension UIColor {
    class var appColor: UIColor {
        return UIColor(red: 244/255, green: 92/255, blue: 9/255, alpha: 1)
    }

    class var orangeColor: UIColor {
        return UIColor(red: 244/255, green: 92/255, blue: 9/255, alpha: 1)
    }

    class var redColor: UIColor {
        return UIColor(red: 237/255, green: 58/255, blue: 59/255, alpha: 1)
    }

    class var grayColor: UIColor {
        return UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)
    }

    class var greenColor: UIColor {
        return UIColor(red: 80/255, green: 172/255, blue: 42/255, alpha: 1)
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
