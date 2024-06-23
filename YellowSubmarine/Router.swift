import Foundation
import UIKit

final class Router {
    private var controller : UIViewController?
    private var targetController : UIViewController?
    private var toPushController : UIViewController?
    private var previousController : UIViewController?
    
    func setRootViewController(controller: UIViewController) {
        self.controller = controller
    }
    
    func setTargetViewController(controller: UIViewController) {
        self.targetController = controller
    }
    
    func setPushController(controller: UIViewController) {
        self.toPushController = controller
    }
    
    func setPreviousController(controller: UIViewController) {
        self.previousController = controller
    }
    
    func nextController() {
        guard let targetController = self.targetController else { return }
        
        NotificationCenter.default.post(name: .setRoot, object: targetController)
    }
    
    func prevController() {
        guard let prevController = self.previousController else { return }
        
        NotificationCenter.default.post(name: .setRoot, object: prevController)
    }
    
    func pushController() {
        guard let toPushController = self.toPushController else { return }
        
        NotificationCenter.default.post(name: .setRoot, object: toPushController)
    }
}
