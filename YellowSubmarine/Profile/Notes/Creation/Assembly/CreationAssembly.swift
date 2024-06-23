import Foundation
import UIKit

final class CreationAssembly {
    static func build() -> UIViewController {
        let model = CreationModel()
        
        let presenter = CreationPresenter(dependencies: .init(model: model))
        
        let controller = CreationViewController(dependencies: .init(presenter: presenter))
        
        return controller
    }
}
