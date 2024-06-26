import Foundation
import UIKit

extension UIViewController {
    
    func createAlert(message : String, buttonText: String, isClosingAction: Bool) {
        
        let alert = UIAlertController(
            title: nil,
            message: message,
            preferredStyle: .alert
        )
        
        var cancelButton : UIAlertAction!
        if isClosingAction {
            cancelButton = UIAlertAction(title: buttonText, style: .cancel) { _ in
                self.dismiss(animated: true)
            }
        } else {
            cancelButton = UIAlertAction(title: buttonText, style: .cancel)
        }

        alert.addAction(cancelButton)
        
        self.present(alert, animated: true)
    }
    
}
