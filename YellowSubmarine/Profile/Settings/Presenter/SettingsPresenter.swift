import Foundation

protocol SettingsPresenterProtocol {
    func loadView(view: SettingsViewProtocol, controller: SettingsViewControllerProtocol)
    
    func logOut()
}

final class SettingsPresenter {
    private let model : SettingsModelProtocol!
    private let loginModel : LoginModel = LoginModel()
    private let profilePresenter : ProfilePresenterProtocol!
    private weak var controller : SettingsViewControllerProtocol?
    private weak var view : SettingsViewProtocol?
    
    struct Dependencies {
        let model : SettingsModelProtocol
        let profilePresenter : ProfilePresenterProtocol
    }
    
    init(dependencies: Dependencies) {
        self.model = dependencies.model
        self.profilePresenter = dependencies.profilePresenter
    }
}

private extension SettingsPresenter {
    private func onSaveChangesTouch(_ dictOfChanges: [String: String]) {
        self.model.updateData(dictOfChanges)
        self.controller?.createAlert(message: "Changes were successfully saved", buttonText: "OK")
        self.profilePresenter.updateData()
    }
    
    private func setUpHandlers() {
        self.view?.saveChanges = { [weak self] dictOfChanges in
            guard let self = self else { return }
            self.onSaveChangesTouch(dictOfChanges)
        }
    }
}

extension SettingsPresenter : SettingsPresenterProtocol {
    func loadView(view: SettingsViewProtocol, controller: SettingsViewControllerProtocol) {
        self.view = view
        self.controller = controller
        
        self.setUpHandlers()
    }
    
    func logOut() {
        loginModel.logOut()
    }
}
