//
//  TheChannels
//
//  Created by Utsav on 29/11/24.
//

import Foundation
import UIKit

extension UILabel {
   
    func startBlink() {
          UIView.animate(withDuration: 0.9,
                delay:0.0,
                options:[.allowUserInteraction, .curveEaseInOut, .autoreverse, .repeat],
                animations: { self.alpha = 0 },
                completion: nil)
      }

      func stopBlink() {
          layer.removeAllAnimations()
          alpha = 1
      }
}
