import Foundation

protocol ListPresenterProtocol : AnyObject {
    func loadView(view: ListViewProtocol, controller: ListViewControllerProtocol)
}

final class ListPresenter {
    private let loadModel : LoadModelProtocol!
    private weak var listView : ListViewProtocol?
    private weak var listController : ListViewControllerProtocol?
    
    struct Dependencies {
        let model : LoadModelProtocol
    }
    
    init(dependencies: Dependencies) {
        self.loadModel = dependencies.model
    }
}

private extension ListPresenter {
    private func setUpHandlers() {
        self.loadModel.getNotes { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let notes):
                listView?.updateData(notes)
            case .failure(let err):
                listController?.createAlert(message: err.localizedDescription, buttonText: "Cancel", isClosingAction: false)
            }
        }
    }
}

extension ListPresenter : ListPresenterProtocol {
    func loadView(view: ListViewProtocol, controller: ListViewControllerProtocol) {
        self.listView = view
        self.listController = controller
        
        self.setUpHandlers()
    }
}
