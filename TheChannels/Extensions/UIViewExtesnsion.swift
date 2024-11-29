//
//  TheChannels
//
//  Created by Utsav on 29/11/24.
//

import Foundation
import UIKit

extension UIView {
    @discardableResult
    func addBorders(edges: UIRectEdge,
                    color: UIColor,
                    inset: CGFloat = 0.0,
                    thickness: CGFloat = 1.0) -> [UIView] {

        var borders = [UIView]()

        @discardableResult
        func addBorder(formats: String...) -> UIView {
            let border = UIView(frame: .zero)
            border.backgroundColor = color
            border.translatesAutoresizingMaskIntoConstraints = false
            addSubview(border)
            addConstraints(formats.flatMap {
                NSLayoutConstraint.constraints(withVisualFormat: $0,
                                               options: [],
                                               metrics: ["inset": inset, "thickness": thickness],
                                               views: ["border": border]) })
            borders.append(border)
            return border
        }

        if edges.contains(.top) || edges.contains(.all) {
            addBorder(formats: "V:|-0-[border(==thickness)]", "H:|-inset-[border]-inset-|")
        }

        if edges.contains(.bottom) || edges.contains(.all) {
            addBorder(formats: "V:[border(==thickness)]-0-|", "H:|-inset-[border]-inset-|")
        }

        if edges.contains(.left) || edges.contains(.all) {
            addBorder(formats: "V:|-inset-[border]-inset-|", "H:|-0-[border(==thickness)]")
        }

        if edges.contains(.right) || edges.contains(.all) {
            addBorder(formats: "V:|-inset-[border]-inset-|", "H:[border(==thickness)]-0-|")
        }

        return borders
    }
    
    func addShadow(offset: CGSize, color: UIColor = .black, opacity: Float = 1, radius: CGFloat = 5.0) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
    }
}

extension UIView {
    
    func embedeInHstack(aligment: UIStackView.Alignment = .fill, margins: NSDirectionalEdgeInsets = .zero) -> UIStackView {
        
        let stack = UIStackView()
        stack.distribution = .fill
        stack.alignment = aligment
        stack.addArrangedSubview(self)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.directionalLayoutMargins = margins
        return stack
    }
    
    func embedeInVstack(aligment: UIStackView.Alignment = .fill, margins: NSDirectionalEdgeInsets = .zero) -> UIStackView {
        
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = aligment
        stack.addArrangedSubview(self)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.directionalLayoutMargins = margins
        return stack
    }
    
    convenience init(alpha: CGFloat) {
        self.init()
        self.alpha = alpha
    }
}
extension UIView {
    func hideWithAnimation(hidden: Bool, duration: Double = 0.4) {
        UIView.transition(with: self, duration: duration, options: .transitionCrossDissolve, animations: {
            self.isHidden = hidden
        })
    }
    
    func alphaWithAnimation(alpha: CGFloat, duration: Double = 0.4) {
        UIView.animate(withDuration: duration) {
            self.alpha = alpha
        }
    }
}

extension UIView {

    func takeScreenshot() -> UIImage {
        // Begin context
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        // Draw view in that context
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        // And finally, get image
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        if (image != nil)
        {
            return image!
        }
        return UIImage()
    }
}


@IBDesignable
extension UIView
{

    @IBInspectable
    public var cornerRadius: CGFloat
    {
        set (radius) {
            self.layer.cornerRadius = radius
            self.layer.masksToBounds = radius > 0
        }

        get {
            return self.layer.cornerRadius
        }
    }

    @IBInspectable
    public var borderWidth: CGFloat
    {
        set (borderWidth) {
            self.layer.borderWidth = borderWidth
        }

        get {
            return self.layer.borderWidth
        }
    }

    @IBInspectable
    public var borderColor:UIColor?
    {
        set (color) {
            self.layer.borderColor = color?.cgColor
        }

        get {
            if let color = self.layer.borderColor
            {
                return UIColor(cgColor: color)
            } else {
                return nil
            }
        }
    }
}
