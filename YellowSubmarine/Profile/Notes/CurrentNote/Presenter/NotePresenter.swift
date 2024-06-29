import Foundation

protocol NotePresenterProtocol : AnyObject {
    func loadView(view: NoteViewProtocol, controller: NoteViewControllerProtocol)
}

final class NotePresenter {
    private var model : NoteModelProtocol!
    private weak var view : NoteViewProtocol?
    private weak var controller : NoteViewControllerProtocol?
    
    struct Dependencies {
        let model : NoteModelProtocol
    }
    
    init(dependencies: Dependencies) {
        self.model = dependencies.model
    }
    
    func setUpNoteData() {
        let noteData = self.model.getNoteData()
        self.view?.noteData = noteData
    }
}

private extension NotePresenter {
    private func setUpHandlers() {
        
    }
}

extension NotePresenter : NotePresenterProtocol {
    func loadView(view: NoteViewProtocol, controller: any NoteViewControllerProtocol) {
        self.view = view
        self.controller = controller
        
        self.setUpHandlers()
    }
}
