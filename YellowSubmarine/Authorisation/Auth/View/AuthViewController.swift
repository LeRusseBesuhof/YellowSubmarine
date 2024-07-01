import UIKit

protocol AuthViewControllerProtocol : ViewControllerProtocol {
    func presentController(_ controller: UIViewController)
    func createAlertSheet(message: String)
}

final class AuthViewController: UIViewController {
    
    private var authView: AuthViewProtocol!
    private var authPresenter: AuthPresenterProtocol!
    
    struct Dependencies {
        let presenter: AuthPresenterProtocol
    }
    
    init(dependencies: Dependencies) {
        self.authView = AuthView(frame: UIScreen.main.bounds)
        self.authPresenter = dependencies.presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func loadView() {
        super.loadView()
        self.authPresenter.loadView(controller: self, view: self.authView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(authView)
    }
}

extension AuthViewController : AuthViewControllerProtocol {
    func presentController(_ controller: UIViewController) {
        self.present(controller, animated: true)
    }
    
    func createAlertSheet(message: String) {
        let alertController = UIAlertController(
            title: "Reset password",
            message: message,
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: "OK", style: .cancel) { _ in
            
            let email = alertController.textFields![0].text
            self.authPresenter.onSendResetPasswordEmailTouched(email ?? "")
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        alertController.addTextField { alertTextField in
            alertTextField.placeholder = "Your email"
        }
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
}
