import Foundation

protocol RegisterPresenterProtocol : AnyObject {
    func loadView(controller: ViewControllerProtocol, view: RegisterViewProtocol)
}

final class RegisterPresenter {
    private let regModel : RegisterModelProtocol
    private let router : Router
    private weak var controller : ViewControllerProtocol?
    private weak var view : RegisterViewProtocol?
    
    struct Dependencies {
        let model : RegisterModelProtocol
        let router : Router
    }
    
    init(dependencies: Dependencies) {
        self.regModel = dependencies.model
        self.router = dependencies.router
    }
}

private extension RegisterPresenter {
    
    private func onRegTouched() {
        
        self.view?.setUserRegData()
        
        self.regModel.userRegistration { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let success):
                if success {
                    onRegisterTouched()
                }
            case .failure(let failure):
                controller?.createAlert(message: failure.rawValue, buttonText: "Cancel")
            }
        }
        
    }
    
    private func onRegisterTouched() {
        self.router.nextController()
    }
    
    private func onLoginTouched() {
        self.router.pushController()
    }
    
    private func setHandlers() {
        
        self.view?.goToAuthHandler = { [weak self] in
            guard let self = self else { return }
            self.onLoginTouched()
        }
        
        self.view?.regAndGoToAuthHandler = { [weak self] in
            guard let self = self else { return }
            self.onRegTouched()
        }
        
    }
}

extension RegisterPresenter : RegisterPresenterProtocol {
    
    func loadView(controller: ViewControllerProtocol, view: RegisterViewProtocol) {
        self.controller = controller
        self.view = view
        
        self.setHandlers()
    }
    
}
