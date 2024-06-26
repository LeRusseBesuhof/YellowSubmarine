import Foundation
import UIKit

final class NoteAssemby {
    static func build() -> UIViewController {
        let model = ListModel()
        
        let presenter = ListPresenter(dependencies: .init(model: model))
        
        let controller = ListViewController(dependencies: .init(presenter: presenter))
        
        return controller
    }
}
