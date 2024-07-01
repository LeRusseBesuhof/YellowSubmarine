import Foundation
import UIKit

protocol AuthPresenterProtocol : AnyObject {
    func loadView(controller: AuthViewControllerProtocol, view: AuthViewProtocol)
    func onSendResetPasswordEmailTouched(_ email: String)
}

final class AuthPresenter {
    private let model : AuthModelProtocol
    private let router : Router
    private weak var view : AuthViewProtocol?
    private weak var controller : AuthViewControllerProtocol?
    
    struct Dependencies {
        let model : AuthModelProtocol
        let router : Router
    }
    
    init(dependencies: Dependencies) {
        self.model = dependencies.model
        self.router = dependencies.router
    }
}

private extension AuthPresenter {
    
    private func onLogTouched() {
        
        self.view?.setAuthUserData()
        
        print(UserData.email)
        print(UserData.password)
        
        self.model.signIn { [weak self] result in
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
        self.controller?.createAlertSheet(message: "An email will be sent to your email address with a link to reset your password. Please check your email")
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
    
    func onSendResetPasswordEmailTouched(_ email: String) {
        model.sendResetEmail(email) { err in
            guard err == nil else {
                self.controller?.createAlert(
                    message: err!.localizedDescription,
                    buttonText: "Cancel",
                    isClosingAction: false
                )
                return
            }
        }
        
        self.controller?.createAlert(
            message: "Email with reset link was successfully sent",
            buttonText: "OK",
            isClosingAction: false
        )
    }
}
