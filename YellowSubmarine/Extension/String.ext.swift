import Foundation
import UIKit

extension String {
    
    static func getUnderlinedString(_ str: String) -> NSAttributedString {
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue]
        let underlineAttributedString = NSAttributedString(string: str, attributes: underlineAttribute)
        return underlineAttributedString
    }
    
    static let male = "\u{FE0F}"
    static let female = "\u{2642}"
}
