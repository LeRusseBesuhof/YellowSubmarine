import UIKit

protocol ProfileViewControllerProtocol : ViewControllerProtocol { }

final class ProfileViewController: UIViewController {
    
    private let profilePresenter : ProfilePresenterProtocol!
    private let profileView : ProfileViewProtocol!
    
    struct Dependencies {
        let presenter : ProfilePresenterProtocol
    }
    
    init(dependencies: Dependencies) {
        self.profilePresenter = dependencies.presenter
        self.profileView = ProfileView(frame: UIScreen.main.bounds)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.profilePresenter.loadView(controller: self, view: profileView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(profileView)
    }
}

extension ProfileViewController : ProfileViewControllerProtocol { }
