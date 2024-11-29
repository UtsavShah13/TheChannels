//
//  TheChannels
//
//  Created by Utsav on 29/11/24.
//

import Foundation
import UIKit

extension String {
    
    var isLink: Bool {
        guard self.count > 0 else { return false }
        let types: NSTextCheckingResult.CheckingType = [.link]
        if let detector = try? NSDataDetector(types: types.rawValue) {
            let range = NSRange(location: 0, length: self.count)
            if detector.numberOfMatches(
                in: self,
                options: NSRegularExpression.MatchingOptions(rawValue: 0),
                range: range
            ) > 0 {
                return true
            }
        }
        return false
    }
    
    var isValidURL: Bool {
        do {
         let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
         if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) {
             // it is a link, if the match covers the whole string
             return match.range.length == self.utf16.count
         }
        } catch {
            print("Error in url")
        }
        return false
     }
    
    var inCurrency: String {
        guard self.count > 0 else { return "$0.00" }
        guard let doubleValue = Double(self) else { return "$0.00" }
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.numberStyle = .currencyAccounting
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: doubleValue)) ?? "$\(doubleValue)"
    }
    
    var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
    
    var inNumber: String {
        guard self.count > 0 else { return "0" }
        guard let doubleValue = Double(self) else { return "0" }
        return NumberFormatter.inNumber(value: doubleValue)
    }
    
    var isPhoneNumber: Bool {
        let value = self.replacingOccurrences(of: "+", with: "")
        return value.isNumber
    }
    
    var isAlphanumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9 ]", options: .regularExpression) == nil
    }
    
    var isAlphabates: Bool {
        return !isEmpty && range(of: "[^a-zA-Z ]", options: .regularExpression) == nil
    }
    
    var inTaxId: String {
        let value = self.replacingOccurrences(of: "-", with: "")
        if value.count < 3 {
            return value
        }
        let first =  value.prefix(2)
        let last = value.dropFirst(2)
        let tax = first + "-" + last
        return String(tax)
    }
    
    var inRoutingNumber: String {
        let value = self.replacingOccurrences(of: "-", with: "")
        if value.count < 6 {
            return value
        }
        let first =  value.prefix(5)
        let last = value.dropFirst(5)
        let tax = first + "-" + last
        return String(tax)
    }
    
    var inFullSSN: String {
        var value = self.replacingOccurrences(of: "-", with: "")
        value = value.replacingOccurrences(of: " ", with: "")
        
        if value.count < 4 {
            return value
        }
        let first =  value.prefix(3)
        let second = String(value.dropFirst(3))
        if second.count < 3 {
            return first + " - " + second
        }
        let middle =  second.prefix(2)
        let last =  second.dropFirst(2)
        let fullSSN = first + " - " + middle + " - " + last
        return String(fullSSN)
    }
    
    var inVerificationCode: String {
        let value = self.replacingOccurrences(of: " ", with: "")
        if value.count < 3 {
            return value
        }
        let first =  value.prefix(3)
        let last = value.dropFirst(3)
        let tax = first + " " + last
        return String(tax)
    }
    
    var valueWithoutCurrency: String {
        var price = self.replacingOccurrences(of: ",", with: "")
        price = price.replacingOccurrences(of: "$", with: "")
        return price
    }
    
    func size(withConstrainedWidth width: CGFloat, font: UIFont) -> CGSize {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return boundingBox.size
    }
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return boundingBox.height
    }
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
    
    /**
     Swift friendly localization syntax, replaces NSLocalizedString.
     - parameter language:
     - returns: The localized string.
     */
    func localizedValue(language: String) -> String {
        let currentLanguage = language
        let bundle: Bundle = .main
        if let path = bundle.path(forResource: currentLanguage, ofType: "lproj"),
            let bundle = Bundle(path: path) {
            return bundle.localizedString(forKey: self, value: nil, table: nil)
        } else if let path = bundle.path(forResource: "Base", ofType: "lproj"),
            let bundle = Bundle(path: path) {
            return bundle.localizedString(forKey: self, value: nil, table: nil)
        }
        return self
    }
    
    func stringByRemovingAll(characters: [Character]) -> String {
        return String(self.filter({ !characters.contains($0) }))
    }
    
    func canOpenUrl() -> Bool {
        guard let url = URL(string: self), UIApplication.shared.canOpenURL(url) else { return false }
        let regEx = "((https|http)://)((\\w|-)+)(([.]|[/])((\\w|-)+))+"
        let predicate = NSPredicate(format: "SELF MATCHES %@", argumentArray: [regEx])
        return predicate.evaluate(with: self)
    }
    
    /// Convert string Date to specified Format. //0001-01-01 00:00:00
    public func toDate(format: String = "yyyy-MM-dd HH:mm:ss", timezone: TimeZone? = nil, local: String = "en_US") -> Date {
        let string = self.replacingOccurrences(of: "T", with: " ")
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: local)
        if let tz = timezone {
            formatter.timeZone = tz
        }
        return formatter.date(from: string) ?? Date()
    }

    var phoneNumberWithoutCode: String {
        return replacingOccurrences(of: "(\\d{3})(\\d{3})(\\d+)", with: "($1) $2-$3", options: .regularExpression, range: nil)
    }
    
    var attributedUnderLineWithGrayText: NSAttributedString {
        let attrs = [NSAttributedString.Key.font: UIFont.regular(sz: 14.0),
                     NSAttributedString.Key.foregroundColor: UIColor.gray,
                     NSAttributedString.Key.underlineStyle: 1] as [NSAttributedString.Key: Any]
        let buttonTitleStr = NSMutableAttributedString(string: self, attributes: attrs)
        let attributedString = NSMutableAttributedString(string: "")
        attributedString.append(buttonTitleStr)
        return attributedString
    }
    
    var attributedUnderLineWithWhiteText: NSAttributedString {
        let attrs = [NSAttributedString.Key.font: UIFont.regular(sz: 14.0),
                     NSAttributedString.Key.foregroundColor: UIColor.white,
                     NSAttributedString.Key.underlineStyle: 1] as [NSAttributedString.Key: Any]
        let buttonTitleStr = NSMutableAttributedString(string: self, attributes: attrs)
        let attributedString = NSMutableAttributedString(string: "")
        attributedString.append(buttonTitleStr)
        return attributedString
    }

    func toPhoneNumberWithoutDash() -> String {
        return self.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "-", with: "")
    }

}

extension Double {
    var inNumber: String {
        return NumberFormatter.inNumber(value: self)
    }
    var inCurrency: String {
        return NumberFormatter.inCurrency(value: self)
    }
}

extension Float {
    var inNumber: String {
        return NumberFormatter.inNumber(value: Double(self))
    }
    
    var inCurrency: String {
        return NumberFormatter.inCurrency(value: Double(self))
    }
}

extension Int {

}

extension NumberFormatter {
    
    class func inNumber(value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 1
        formatter.roundingMode = .halfUp
        return formatter.string(from: NSNumber(value: value)) ?? "0"
    }
    
    class func inCurrency(value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.numberStyle = .currencyAccounting
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: value)) ?? "$\(value)"
    }
}

extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
