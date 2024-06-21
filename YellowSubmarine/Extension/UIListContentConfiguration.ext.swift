import Foundation
import UIKit

extension UIListContentConfiguration {
    mutating func setConfig(text: String, font: UIFont, image: String, sndText: String, sndTextColor: UIColor, sndTextFont: UIFont) -> UIListContentConfiguration {
        self.text = text
        textProperties.font = font
        textProperties.numberOfLines = .zero
        
        self.secondaryText = sndText
        secondaryTextProperties.color = sndTextColor
        secondaryTextProperties.font = sndTextFont
        
        self.image = UIImage(named: image)
        imageProperties.maximumSize = CGSize(width: 36, height: 36)
        imageToTextPadding = 20
        
        return self
    }
}
