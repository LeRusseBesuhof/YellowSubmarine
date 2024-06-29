import Foundation
import UIKit

final class NoteAssembly {
    static func build(prevController: UIViewController, _ note: Note) -> UIViewController {
        let model = NoteModel(note)
        
        let presenter = NotePresenter(dependencies: .init(model: model))
        
        let controller = NoteViewController(dependencies: .init(presenter: presenter))
        
        return controller
    }
}
