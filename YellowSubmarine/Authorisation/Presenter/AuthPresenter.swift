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

extension AuthPresenter : AuthPresenterProtocol {
    func loadView(controller: AuthViewControllerProtocol, view: AuthViewProtocol) {
        <#code#>
    }
}

/*
 guard let self = self else { return }
 
 authModel.signIn(userData: authUserData) { result in
     
     switch result {
     case .success(let success):
         if success {
             NotificationCenter.default.post(name: .setRoot, object: ProfileViewController())
         }

     case .failure(let failure):
         self.createAlert(errorMessage: failure.rawValue)
     }
 }
 */
