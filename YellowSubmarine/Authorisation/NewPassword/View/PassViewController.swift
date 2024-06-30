import UIKit

protocol PassViewControllerProtocol : ViewControllerProtocol {
    
}

final class PassViewController: UIViewController {
    private let pView : PassViewProtocol!
    private let presenter : PassPresenterProtocol!
    
    struct Dependencies {
        let presenter : PassPresenter
    }
    
    init(dependencies: Dependencies) {
        self.pView = PassView(frame: UIScreen.main.bounds)
        self.presenter = dependencies.presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(pView)
    }
    
    override func loadView() {
        super.loadView()
        presenter.loadView(view: pView, controller: self)
    }
}

extension PassViewController : PassViewControllerProtocol {
    
}
