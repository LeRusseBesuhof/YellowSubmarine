import Foundation
import UIKit

protocol RegisterPresenterProtocol : AnyObject {
    func loadView(controller: TestRegisterViewController, view: RegisterViewProtocol)
}

final class RegisterPresenter {
    private let regModel : RegistrationModelProtocol
    private let router : Router
    private weak var controller : TestRegisterViewControllerProtocol?
    private weak var view : RegisterViewProtocol?
    
    struct Dependencies {
        let model : RegistrationModelProtocol
        let router : Router
    }
    
    init(dependencies: Dependencies) {
        self.regModel = dependencies.model
        self.router = dependencies.router
    }
}

private extension RegisterPresenter {
    
    private func registerTouched() {
        // reg logic
        loginTouched()
    }
    
    private func loginTouched() {
        self.router.nextController()
    }
    
    private func setHandlers() {
        
        self.view?.goToAuthHandler = { [weak self] in
            guard let self = self else { return }
            self.loginTouched()
        }
        
        self.view?.regAndGoToAuthHandler = { [weak self] in
            guard let self = self else { return }
            self.registerTouched()
        }
        
    }
}

extension RegisterPresenter : RegisterPresenterProtocol {
    
    func loadView(controller: TestRegisterViewController, view: RegisterViewProtocol) {
        self.controller = controller
        self.view = view
        
        self.setHandlers()
    }
    
}
