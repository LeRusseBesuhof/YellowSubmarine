import Foundation

protocol CreationPresenterProtocol : AnyObject {
    func loadView(view: CreationViewProtocol, controller: CreationViewControllerProtocol)
}

final class CreationPresenter {
    private let creationModel : CreationModelProtocol!
    weak var creationView : CreationViewProtocol?
    weak var creationController : CreationViewControllerProtocol?
    
    struct Dependencies {
        let model : CreationModelProtocol
    }
    
    init(dependencies: Dependencies) {
        self.creationModel = dependencies.model
    }
}

private extension CreationPresenter {
    private func onCreateNoteTouched() {
        creationView?.getNoteData(completion: { result in
            switch result {
            case .success(let data):
                let curNoteData = NoteData(name: data.name, text: data.text)
                creationModel.uploadNote(curNoteData)
            case .failure(let err):
                creationController?.createAlert(message: err.rawValue, buttonText: "Cancel")
            }
        })
    }
    
    private func setUpHandlers() {
        self.creationView?.createNote = { [weak self] in
            guard let self = self else { return }
            
            onCreateNoteTouched()
        }
    }
}

extension CreationPresenter : CreationPresenterProtocol {
    func loadView(view: CreationViewProtocol, controller: CreationViewControllerProtocol) {
        self.creationView = view
        self.creationController = controller
        
        self.setUpHandlers()
    }
}
