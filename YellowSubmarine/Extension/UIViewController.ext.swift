import Foundation
import UIKit

extension UIViewController {
    
    func createAlert(errorMessage : String) {
        
        let alert = UIAlertController(
            title: nil,
            message: errorMessage,
            preferredStyle: .alert
        )
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(cancelButton)
        
        self.present(alert, animated: true)
    }
    
}
