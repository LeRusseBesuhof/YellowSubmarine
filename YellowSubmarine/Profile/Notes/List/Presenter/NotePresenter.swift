import Foundation

protocol NotePresenterProtocol : AnyObject {
    func loadView(view: NoteViewProtocol, controller: NoteViewControllerProtocol)
}

final class NotePresenter {
    private let noteModel : NoteModelProtocol!
    private weak var noteView : NoteViewProtocol?
    private weak var noteController : NoteViewControllerProtocol?
    
    struct Dependencies {
        let model : NoteModelProtocol
    }
    
    init(dependencies: Dependencies) {
        self.noteModel = dependencies.model
    }
}

private extension NotePresenter {
    private func setUpHandlers() {
        
    }
}

extension NotePresenter : NotePresenterProtocol {
    func loadView(view: NoteViewProtocol, controller: NoteViewControllerProtocol) {
        self.noteView = view
        self.noteController = controller
        
        self.setUpHandlers()
    }
}
