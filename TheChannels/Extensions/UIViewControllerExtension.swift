//
//  TheChannels
//
//  Created by Utsav on 29/11/24.
//

import UIKit
import StoreKit


extension UIViewController {
    
    func redirectToAppStore() {
        if let url = URL(string: "itms-apps://itunes.apple.com/app/id<YOUR_APP_ID>") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func shareURL(from viewController: UIViewController, urlString: String) {
        if let url = URL(string: urlString) {
            let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
            
            // For iPad support
            if let popoverController = activityVC.popoverPresentationController {
                popoverController.sourceView = viewController.view
                popoverController.sourceRect = CGRect(x: viewController.view.bounds.midX,
                                                      y: viewController.view.bounds.midY,
                                                      width: 0, height: 0)
                popoverController.permittedArrowDirections = []
            }
            
            viewController.present(activityVC, animated: true, completion: nil)
        } else {
            print("Invalid URL")
        }
    }
    
    func setLeftAlignTitleView(font: UIFont, text: String, textColor: UIColor) {
        guard let navFrame = navigationController?.navigationBar.frame else{
            return
        }
        let parentView = UIView(frame: CGRect(x: 10, y: 0, width: navFrame.width*3, height: navFrame.height))
        self.navigationItem.titleView = parentView

        let label = UILabel(frame: .init(x: parentView.frame.minX, y: parentView.frame.minY, width: parentView.frame.width, height: parentView.frame.height))
        label.backgroundColor = .clear
        label.numberOfLines = 1
        label.font = font
        label.textAlignment = .left
        label.textColor = textColor
        label.text = text
        parentView.addSubview(label)
    }

    func openURL(link: String) {
        if let url = NSURL(string: link) {
            UIApplication.shared.open(url as URL)
        }
    }
}

extension UIView {
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
    let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
    let mask = CAShapeLayer()
    mask.path = path.cgPath
    self.layer.mask = mask
  }
}

extension UITableView {
    func removeGroupedSpaceFromTableView() {
        var frame = CGRect.zero
        frame.size.height = .leastNormalMagnitude
        self.tableHeaderView = UIView(frame: frame)
    }
}

extension SKStoreReviewController {
    public static func requestReviewInCurrentScene() {
        if #available(iOS 13.0, *) {
            if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                if #available(iOS 14.0, *) {
                    requestReview(in: scene)
                } else {
                    // Fallback on earlier versions
                }
            }
        } else {
            // Fallback on earlier versions
        }
    }
}
