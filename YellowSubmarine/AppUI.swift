import Foundation
import UIKit

final class AppUI {
    
    static func createImageView(image: UIImage, tintColor: UIColor, cornerRadius: CGFloat, borderWidth: CGFloat) -> UIImageView {
        .config(view: UIImageView()) {
            $0.image = image
            $0.tintColor = tintColor
            $0.layer.cornerRadius = cornerRadius
            $0.backgroundColor = .white
            $0.layer.borderColor = tintColor.cgColor
            $0.layer.borderWidth = borderWidth
            $0.contentMode = .center
            $0.clipsToBounds = true
            $0.isUserInteractionEnabled = true
        }
    }
    
    static func createLabel(withText text: String, textColor color: UIColor , font: UIFont, alignment: NSTextAlignment, isUnderlined: Bool = false) -> UILabel {
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
            .config(view: UITextField()) {
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
            }
        }()
    }
    
}
