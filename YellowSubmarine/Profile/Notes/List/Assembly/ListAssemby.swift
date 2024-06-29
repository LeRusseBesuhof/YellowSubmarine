import Foundation
import UIKit

final class ListAssemby {
    static func build() -> UIViewController {
        let model = LoadModel()
        
        let presenter = ListPresenter(dependencies: .init(model: model))
        
        let controller = ListViewController(dependencies: .init(presenter: presenter))
        
        return controller
    }
}
