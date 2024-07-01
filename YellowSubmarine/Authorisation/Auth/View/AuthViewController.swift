import UIKit

protocol AuthViewControllerProtocol : ViewControllerProtocol {
    func presentController(_ controller: UIViewController)
    func createAlertSheet(message: String)
}

final class AuthViewController: UIViewController {
    
    private var aView: AuthViewProtocol!
    private var presenter: AuthPresenterProtocol!
    
    struct Dependencies {
        let presenter: AuthPresenterProtocol
    }
    
    init(dependencies: Dependencies) {
        self.aView = AuthView(frame: UIScreen.main.bounds)
        self.presenter = dependencies.presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func loadView() {
        super.loadView()
        self.presenter.loadView(controller: self, view: self.aView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(aView)
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
            self.presenter.onSendResetPasswordEmailTouched(email ?? "")
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
