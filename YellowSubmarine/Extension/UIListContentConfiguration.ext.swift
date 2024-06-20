import Foundation
import UIKit

extension UIListContentConfiguration {
    mutating func setConfig(text: String, font: UIFont, image: String) -> UIListContentConfiguration {
        self.text = text
        self.textProperties.font = font
        
        self.image = UIImage(named: image)
        self.imageProperties.maximumSize = CGSize(width: 40, height: 40)
        self.imageToTextPadding = 20
        
        return self
    }
}
