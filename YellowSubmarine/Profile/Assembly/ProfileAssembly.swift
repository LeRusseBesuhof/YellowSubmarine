import Foundation
import UIKit

final class ProfileAssembly {
    
    static func build() -> UIViewController {
        let model = ProfileModel()
        let router = Router()
        
        let presenter = ProfilePresenter(dependencies: .init(model: model, router: router))
        
        let controller = UINavigationController(rootViewController: ProfileViewController(dependencies: .init(presenter: presenter)))
        
        router.setRootViewController(controller: controller)
        
        return controller
    }
    
}
