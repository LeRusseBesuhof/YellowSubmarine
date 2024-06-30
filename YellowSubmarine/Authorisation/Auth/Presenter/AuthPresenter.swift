import Foundation
import UIKit

protocol AuthPresenterProtocol : AnyObject {
    func loadView(controller: AuthViewControllerProtocol, view: AuthViewProtocol)
}

final class AuthPresenter {
    private let authModel : AuthModelProtocol
    private let router : Router
    private weak var view : AuthViewProtocol?
    private weak var controller : AuthViewControllerProtocol?
    
    struct Dependencies {
        let model : AuthModelProtocol
        let router : Router
    }
    
    init(dependencies: Dependencies) {
        self.authModel = dependencies.model
        self.router = dependencies.router
    }
}

private extension AuthPresenter {
    
    private func onLogTouched() {
        
        self.view?.setAuthUserData()
        
        print(UserData.email)
        print(UserData.password)
        
        self.authModel.signIn { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let success):
                if success {
                    router.nextController()
                }

            case .failure(let failure):
                controller?.createAlert(message: failure.rawValue, buttonText: "Cancel", isClosingAction: false)
            }
        }
        
    }
    
    private func onRegTouched() {
        self.router.prevController()
    }
    
    private func onPassChangeTouched() {
        guard let curController = self.controller as? UIViewController else {
            print("not controller")
            return
        }
        
        let passController = PassAssembly.build(targetController: curController)
        self.controller?.presentController(passController)
    }
    
    private func setHandlers() {
        
        self.view?.goToRegHandler = { [weak self] in
            guard let self = self else { return }
            
            onRegTouched()
        }
        
        self.view?.goToProfileHandler = { [weak self] in
            guard let self = self else { return }
            
            onLogTouched()
        }
        
        self.view?.goToPasswordChangeHandler = { [weak self] in
            guard let self = self else { return }
            
            onPassChangeTouched()
        }
    }
}

extension AuthPresenter : AuthPresenterProtocol {
    func loadView(controller: AuthViewControllerProtocol, view: AuthViewProtocol) {
        self.controller = controller
        self.view = view
        
        self.setHandlers()
    }
}
