import UIKit

final class RegisterViewController: UIViewController {

    private var rView: RegisterViewProtocol!
    private var presenter: RegisterPresenterProtocol!
    
    struct Dependencies {
        let presenter: RegisterPresenterProtocol
    }
    
    init(dependencies: Dependencies) {
        self.rView = RegisterView(frame: UIScreen.main.bounds)
        self.presenter = dependencies.presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func loadView() {
        super.loadView()
        self.presenter.loadView(controller: self, view: self.rView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(rView)
    }
    
}

extension RegisterViewController : ViewControllerProtocol { }
