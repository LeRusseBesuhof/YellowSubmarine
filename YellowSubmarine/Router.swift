import Foundation
import UIKit

final class Router {
    private var controller : UIViewController?
    private var targetController : UIViewController?
    
    func setRootViewController(controller: UIViewController) {
        self.controller = controller
    }
    
    func setTargetViewController(controller: UIViewController) {
        self.targetController = controller
    }
    
    func nextController() {
        guard let targetController = self.targetController else { return }
        
        NotificationCenter.default.post(name: .setRoot, object: targetController)
    }
}
