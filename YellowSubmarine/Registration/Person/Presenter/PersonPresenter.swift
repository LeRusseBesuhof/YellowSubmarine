import Foundation

protocol PersonPresenterProtocol : AnyObject {
    func loadView(controller: ViewControllerProtocol, view: PersonViewProtocol)
}

final class PersonPresenter {
    let personModel : PersonModelProtocol
    let router : Router
    weak var view : PersonViewProtocol?
    weak var controller : ViewControllerProtocol?
    
    struct Dependencies {
        let model : PersonModelProtocol
        let router : Router
    }
    
    init(dependencies: Dependencies) {
        self.personModel = dependencies.model
        self.router = dependencies.router
    }
}

private extension PersonPresenter {
    
    private func onSendDataTouched() {
        
    }
    
    private func setHandlers() {
        self.view?.sendDate = { [weak self] in
            guard let self = self else { return }
            self.onSendDataTouched()
        }
    }
}

extension PersonPresenter : PersonPresenterProtocol {
    func loadView(controller: ViewControllerProtocol, view: PersonViewProtocol) {
        self.controller = controller
        self.view = view
        
        self.setHandlers()
    }
}
