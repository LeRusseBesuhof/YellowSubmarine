import Foundation
import UIKit

final class RegisterAssembly {
    
    static func build() -> UIViewController {
        let model = RegisterModel()
        let router = Router()
        
        let presenter = RegisterPresenter(
            dependencies: .init(model: model, router: router)
        )
        
        let controller = RegisterViewController(
            dependencies: .init(presenter: presenter)
        )
        
        let targetController = AuthAssembly.build(prevController: controller)
        
        router.setRootViewController(controller: controller)
        router.setTargetViewController(controller: targetController)
        
        return controller
    }
    
}
