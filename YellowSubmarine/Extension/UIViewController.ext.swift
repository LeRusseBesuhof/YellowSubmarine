import Foundation
import UIKit

extension UIViewController {
    
    func createAlert(message : String, buttonText: String = "Cancel") {
        
        let alert = UIAlertController(
            title: nil,
            message: message,
            preferredStyle: .alert
        )
        
        let cancelButton = UIAlertAction(title: buttonText, style: .cancel)
        
        alert.addAction(cancelButton)
        
        self.present(alert, animated: true)
    }
    
}
