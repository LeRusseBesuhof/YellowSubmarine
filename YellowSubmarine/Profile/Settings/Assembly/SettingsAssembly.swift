import Foundation
import UIKit

final class SettingsAssembly {
    static func build() -> UIViewController {
        let model = SettingsModel()
        
        let presenter = SettingsPresenter(dependencies: .init(model: model))
        
        let controller = SettingsViewController(dependencies: .init(presenter: presenter))
        
        return controller
    }
}
