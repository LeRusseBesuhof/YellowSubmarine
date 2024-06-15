import Foundation
import UIKit

final class AuthAssembly {
    
    static func build(prevController: UIViewController) -> UIViewController {
        let model = AuthModel()
        let router = Router()
        
        let presenter = AuthPresenter(
            dependencies: .init(model: model, router: router))
        
        let controller = AuthViewController(dependencies: .init(presenter: presenter))
        
        let targetController = ProfileViewController()
        
        router.setRootViewController(controller: controller)
        router.setTargetViewController(controller: targetController)
        router.setPreviousController(controller: prevController)
        
        return controller
    }
    
}
