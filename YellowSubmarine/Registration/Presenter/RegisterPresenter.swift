import Foundation
import UIKit

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
        
        guard let initialUserRegData = self.view?.getUserRegData() else { return }
        
        self.regModel.userRegistration(userRegData: initialUserRegData) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let success):
                if success {
                    onLoginTouched()
                }
            case .failure(let failure):
                controller?.createAlert(errorMessage: failure.rawValue)
            }
        }
        
    }
    
    private func onLoginTouched() {
        self.router.nextController()
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
