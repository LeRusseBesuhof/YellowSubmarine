import Foundation
import UIKit

extension String {
    static let setRoot = "setRoot"
    
    static func getUnderlinedString(_ str: String) -> NSAttributedString {
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue]
        let underlineAttributedString = NSAttributedString(string: str, attributes: underlineAttribute)
        return underlineAttributedString
    }
}
