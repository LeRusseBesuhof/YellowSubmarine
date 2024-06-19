import Foundation

protocol ProfilePresenterProtocol : AnyObject {
    func loadView(controller: ProfileViewControllerProtocol, view: ProfileViewProtocol)
}

final class ProfilePresenter {
    let model : ProfileModelProtocol!
    let router : Router!
    weak var view : ProfileViewProtocol?
    weak var controller : ProfileViewControllerProtocol?
    
    struct Dependencies {
        let model : ProfileModelProtocol
        let router : Router
    }
    
    init(dependencies: Dependencies) {
        self.model = dependencies.model
        self.router = dependencies.router
    }
    
}

private extension ProfilePresenter {
    
    private func setHandlers() {
        self.view?.currentUserData = self.model.loadUserData()
    }
    
}

extension ProfilePresenter : ProfilePresenterProtocol {
    func loadView(controller: ProfileViewControllerProtocol, view: ProfileViewProtocol) {
        self.controller = controller
        self.view = view
        
        self.setHandlers()
    }
}
