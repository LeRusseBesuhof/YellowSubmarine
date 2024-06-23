import UIKit

protocol CreationViewControllerProtocol : ViewControllerProtocol {
    
}

final class CreationViewController: UIViewController {
    private let creationView : CreationViewProtocol!
    private let creationPresenter : CreationPresenterProtocol!
    
    struct Dependencies {
        let presenter : CreationPresenterProtocol
    }
    
    init(dependencies: Dependencies) {
        self.creationView = CreationView(frame: UIScreen.main.bounds)
        self.creationPresenter = dependencies.presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        creationPresenter.loadView(view: creationView, controller: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(creationView)
    }
    
}

extension CreationViewController : CreationViewControllerProtocol {
    
}
