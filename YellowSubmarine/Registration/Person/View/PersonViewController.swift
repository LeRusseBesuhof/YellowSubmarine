import UIKit

final class PersonViewController: UIViewController {

    private let personPresenter : PersonPresenterProtocol!
    private let personView : PersonViewProtocol!
    
    struct Dependencies {
        let presenter : PersonPresenterProtocol
    }
    
    init(dependencies: Dependencies) {
        self.personView = PersonView(frame: UIScreen.main.bounds)
        self.personPresenter = dependencies.presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.personPresenter.loadView(controller: self, view: personView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(personView)
    }
    
}

extension PersonViewController : ViewControllerProtocol {
    
}
