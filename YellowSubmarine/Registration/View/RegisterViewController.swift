import UIKit

protocol RegisterViewControllerProtocol : AnyObject { }

final class RegisterViewController: UIViewController {

    private var registerView: RegisterViewProtocol!
    private var registerPresenter: RegisterPresenterProtocol!
    
    struct Dependencies {
        let presenter: RegisterPresenterProtocol
    }
    
    init(dependencies: Dependencies) {
        self.registerView = RegisterView(frame: UIScreen.main.bounds)
        self.registerPresenter = dependencies.presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func loadView() {
        super.loadView()
        self.registerPresenter.loadView(controller: self, view: self.registerView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(registerView)
    }
    
}

extension RegisterViewController : RegisterViewControllerProtocol { }
