import Foundation
import UIKit

final class NoteAssemby {
    static func build() -> UIViewController {
        let model = NoteModel()
        
        let presenter = NotePresenter(dependencies: .init(model: model))
        
        let controller = NoteViewController(dependencies: .init(presenter: presenter))
        
        return controller
    }
}
