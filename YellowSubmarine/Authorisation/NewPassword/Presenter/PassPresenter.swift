import Foundation

protocol PassPresenterProtocol : AnyObject {
    func loadView(view: PassViewProtocol, controller: PassViewControllerProtocol)
}

final class PassPresenter {
    private let router : Router!
    private let model : PassModelProtocol!
    private weak var view : PassViewProtocol?
    private weak var controller : PassViewControllerProtocol?
    
    struct Dependencies {
        let model : PassModelProtocol
        let router : Router
    }
    
    init(dependencies: Dependencies) {
        self.model = dependencies.model
        self.router = dependencies.router
    }
    
}

private extension PassPresenter {
    func setUpHandlers() {
        
    }
}

extension PassPresenter : PassPresenterProtocol {
    func loadView(view: PassViewProtocol, controller: PassViewControllerProtocol) {
        self.view = view
        self.controller = controller
        
        self.setUpHandlers()
    }
}
