import Foundation
import UIKit

final class SettingsAssembly {
    static func build(_ profilePresenter: ProfilePresenterProtocol) -> UIViewController {
        let model = SettingsModel()
        
        let presenter = SettingsPresenter(dependencies: .init(model: model, profilePresenter: profilePresenter))
        
        let controller = SettingsViewController(dependencies: .init(presenter: presenter))
        
        return controller
    }
}
