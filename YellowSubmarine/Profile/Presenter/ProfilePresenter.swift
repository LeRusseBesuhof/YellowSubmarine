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
        self.model.loadUserData { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let success):
                if success {
                    print(UserData.nick, UserData.gift)
                }
                // view?.currentUserData = userData
                // view?.updateData()
            case .failure(let err):
                controller?.createAlert(errorMessage: err.localizedDescription)
            }
        }
    }
    
}

extension ProfilePresenter : ProfilePresenterProtocol {
    func loadView(controller: ProfileViewControllerProtocol, view: ProfileViewProtocol) {
        self.controller = controller
        self.view = view
        
        self.setHandlers()
    }
}
