import Foundation
import UIKit

final class PassAssembly {
    static func build(targetController: UIViewController) -> UIViewController {
        let model = PassModel()
        let router = Router()
        
        let presenter = PassPresenter(dependencies: .init(model: model, router: router))
        
        let controller = PassViewController(dependencies: .init(presenter: presenter))
        
        router.setTargetViewController(controller: targetController)
        
        return controller
    }
}
