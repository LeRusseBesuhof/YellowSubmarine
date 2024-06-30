import Foundation
import UIKit

protocol ListPresenterProtocol : AnyObject {
    func loadView(view: ListViewProtocol, controller: ListViewControllerProtocol)
}

final class ListPresenter {
    private let model : LoadModelProtocol!
    private weak var view : ListViewProtocol?
    private weak var controller : ListViewControllerProtocol?
    
    struct Dependencies {
        let model : LoadModelProtocol
    }
    
    init(dependencies: Dependencies) {
        self.model = dependencies.model
    }
}

private extension ListPresenter {
    private func onSelectNoteTouched(_ note: Note) {
        guard let curController = controller as? UIViewController else {
            print("can't transform to UIViewController")
            return
        }
        
        let noteController = NoteAssembly.build(prevController: curController, note)
        self.controller?.presentNote(noteController)
    }
    
    private func setUpHandlers() {
        self.model.getNotes { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let notes):
                view?.updateData(notes)
            case .failure(let err):
                controller?.createAlert(message: err.localizedDescription, buttonText: "Cancel", isClosingAction: false)
            }
        }
        
        self.view?.selectNote = { [weak self] note in
            guard let self = self else { return }
            
            self.onSelectNoteTouched(note)
        }
    }
}

extension ListPresenter : ListPresenterProtocol {
    func loadView(view: ListViewProtocol, controller: ListViewControllerProtocol) {
        self.view = view
        self.controller = controller
        
        self.setUpHandlers()
    }
}
