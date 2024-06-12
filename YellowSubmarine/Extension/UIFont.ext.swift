import Foundation
import UIKit

extension UIFont {
    
    static func getMontserratFont(fontType: MontserratFontType = .regular, fontSize: CGFloat) -> UIFont {
        .init(name: fontType.rawValue, size: fontSize) ?? systemFont(ofSize: fontSize)
    }
    
    static func getMeriendaFont(fontType: MeriendaFontType = .regular, fontSize: CGFloat) -> UIFont {
        .init(name: fontType.rawValue, size: fontSize) ?? systemFont(ofSize: fontSize)
    }
    
    static func getAmitaFont(fontType: AmitaFontType = .regular, fontSize: CGFloat) -> UIFont {
        .init(name: fontType.rawValue, size: fontSize) ?? systemFont(ofSize: fontSize)
    }
    
}

enum MontserratFontType : String {
    case regular = "MontserratRoman-Regular"
    case bold = "MontserratRoman-Bold"
}

enum MeriendaFontType : String {
    case regular = "Merienda-Regular"
    case bold = "Merienda-Regular_Bold"
}

enum AmitaFontType : String {
    case regular = "Amita-Regular"
    case bold = "Amita-Bold"
}
