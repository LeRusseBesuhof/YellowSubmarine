import UIKit

protocol SettingsViewControllerProtocol : ViewControllerProtocol {
    
}

final class SettingsViewController: UIViewController {

    private let settingsPresenter : SettingsPresenterProtocol!
    private let settingsView : SettingsViewProtocol!
    
    struct Dependencies {
        let presenter : SettingsPresenterProtocol
    }
    
    init(dependencies: Dependencies) {
        self.settingsView = SettingsView(frame: UIScreen.main.bounds)
        self.settingsPresenter = dependencies.presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.settingsPresenter.loadView(view: settingsView, controller: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        view.addSubview(settingsView)
    }

}

private extension SettingsViewController {
    func setUpNavigationBar() {
        navigationController?.navigationBar.tintColor = .white
        title = "Settings"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}

extension SettingsViewController : SettingsViewControllerProtocol {
    
}
