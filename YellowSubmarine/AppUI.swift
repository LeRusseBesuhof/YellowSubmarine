import Foundation
import UIKit

final class AppUI {
    
    static func createCanvasImageView(image: UIImage) -> UIImageView {
        {
            $0.isUserInteractionEnabled = true
            $0.clipsToBounds = true
            $0.contentMode = .scaleAspectFill
            return $0
        }(UIImageView(image: image))
    }
    
    static func createLabel(withText text: String, textColor color: UIColor , font: UIFont, alignment: NSTextAlignment, isUnderlined: Bool) -> UILabel {
        .config(view: UILabel()) {
            $0.textColor = color
            $0.font = font
            $0.textAlignment = alignment
            $0.numberOfLines = .zero
            if isUnderlined {
                $0.attributedText = String.getUnderlinedString(text)
            } else {
                $0.text = text
            }
        }
    }
    
    static func createTextField(withPlaceholder text: String, placeholderColor: UIColor , bgColor: UIColor, font: UIFont, textColor: UIColor, leftViewPic: String, cornerRadius: CGFloat) -> UITextField {
        {
            $0.layer.cornerRadius = cornerRadius
            $0.backgroundColor = bgColor
            $0.textColor = textColor
            $0.tintColor = placeholderColor
            
            let attributes = [
                NSAttributedString.Key.foregroundColor: placeholderColor,
                NSAttributedString.Key.font : font
            ]

            $0.attributedPlaceholder = NSAttributedString(string: text, attributes:attributes)
            
            let imageView : UIImageView = {
                $0.image = UIImage(systemName: leftViewPic)
                return $0
            }(UIImageView(frame: CGRect(x: 10, y: 12, width: 20, height: 16)))
            
            let leftView : UIView = {
                $0.addSubview(imageView)
                $0.layer.cornerRadius = cornerRadius
                return $0
            }(UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40)))
            
            $0.leftView = leftView
            $0.leftViewMode = .always
            return $0
        }(UITextField())
    }
    
}
