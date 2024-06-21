import Foundation

protocol SettingsPresenterProtocol {
    func loadView(view: SettingsViewProtocol, controller: SettingsViewControllerProtocol)
}

final class SettingsPresenter {
    private let model : SettingsModelProtocol!
    private weak var controller : SettingsViewControllerProtocol?
    private weak var view : SettingsViewProtocol?
    
    struct Dependencies {
        let model : SettingsModelProtocol
    }
    
    init(dependencies: Dependencies) {
        self.model = dependencies.model
    }
}

extension SettingsPresenter : SettingsPresenterProtocol {
    func loadView(view: SettingsViewProtocol, controller: SettingsViewControllerProtocol) {
        self.view = view
        self.controller = controller
    }
}
