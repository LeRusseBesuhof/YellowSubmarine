import UIKit

protocol SettingsViewControllerProtocol : ViewControllerProtocol {
    func createAlertSheet(message: String)
}

final class SettingsViewController: UIViewController {

    private let presenter : SettingsPresenterProtocol!
    private let sView : SettingsViewProtocol!
    
    struct Dependencies {
        let presenter : SettingsPresenterProtocol
    }
    
    init(dependencies: Dependencies) {
        self.sView = SettingsView(frame: UIScreen.main.bounds)
        self.presenter = dependencies.presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.presenter.loadView(view: sView, controller: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(sView)
        setUpNavigationBar(alertMessage: "Do you want to log out?")
    }

}

private extension SettingsViewController {
    func setUpNavigationBar(alertMessage: String) {
        let logOutBarButton = UIBarButtonItem(
            title: "Exit",
            primaryAction: UIAction { [weak self] _ in
                guard let self = self else { return }
                
                createAlertSheet(message: alertMessage)
            }
        )
        
        navigationItem.rightBarButtonItem = logOutBarButton
        navigationController?.navigationBar.tintColor = .white
        
        title = "Settings"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}

extension SettingsViewController : SettingsViewControllerProtocol {
    func createAlertSheet(message: String) {
        let alertController = UIAlertController(
            title: "",
            message: message,
            preferredStyle: .actionSheet
        )
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let quitAction = UIAlertAction(title: "Log out", style: .destructive) { [weak self] _ in
            guard let self = self else { return }
            
            presenter.logOut()
        }
        
        alertController.addAction(quitAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
}
