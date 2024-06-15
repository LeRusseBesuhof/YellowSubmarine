import Foundation
import UIKit

extension String {
    
    static func getUnderlinedString(_ str: String) -> NSAttributedString {
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue]
        let underlineAttributedString = NSAttributedString(string: str, attributes: underlineAttribute)
        return underlineAttributedString
    }
    
    // MARK: Reg & Auth default values
    static let simpleNickname = "Simple Nickname"
    static let simpleEmail = "Simple Email"
    static let simplePassword = "SimplePassword"
}
