import Foundation
import UIKit

final class PersonAssembly {
    
    static func build(prevController: UIViewController) -> UIViewController {
        let router = Router()
        let model = PersonModel()
        
        let presenter = PersonPresenter(dependencies: .init(model: model, router: router))
        
        let controller = PersonViewController(dependencies: .init(presenter: presenter))
        
        let targetController = AuthAssembly.build(prevController: prevController)
        
        router.setRootViewController(controller: controller)
        router.setTargetViewController(controller: targetController)
        
        return controller
    }
    
}
