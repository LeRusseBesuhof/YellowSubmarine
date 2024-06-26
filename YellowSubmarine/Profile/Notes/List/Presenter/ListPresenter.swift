import Foundation

protocol ListPresenterProtocol : AnyObject {
    func loadView(view: ListViewProtocol, controller: ListViewControllerProtocol)
}

final class ListPresenter {
    private let listModel : ListModelProtocol!
    private weak var listView : ListViewProtocol?
    private weak var listController : ListViewControllerProtocol?
    
    struct Dependencies {
        let model : ListModelProtocol
    }
    
    init(dependencies: Dependencies) {
        self.listModel = dependencies.model
    }
}

private extension ListPresenter {
    private func setUpHandlers() {
        
    }
}

extension ListPresenter : ListPresenterProtocol {
    func loadView(view: ListViewProtocol, controller: ListViewControllerProtocol) {
        self.listView = view
        self.listController = controller
        
        self.setUpHandlers()
    }
}
