import Foundation
import UIKit
import SDWebImage

extension UIListContentConfiguration {
    mutating func setConfig(text: String, font: UIFont, isURL: Bool = false, image: String, sndText: String, sndTextColor: UIColor, sndTextFont: UIFont) -> UIListContentConfiguration {
        self.text = text
        textProperties.font = font
        textProperties.numberOfLines = .zero
        
        self.secondaryText = .middlePoint + sndText
        secondaryTextProperties.color = sndTextColor
        secondaryTextProperties.font = sndTextFont
        
        if isURL {
            let imageView = UIImageView()
            if let urlString = URL(string: image) {
                imageView.sd_setImage(with: urlString)
            }
            self.image = imageView.image
        } else {
            self.image = UIImage(named: image)
        }
        imageProperties.maximumSize = CGSize(width: 36, height: 36)
        imageToTextPadding = 20
        
        return self
    }
}
