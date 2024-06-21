import UIKit

protocol ProfileViewControllerProtocol : ViewControllerProtocol { }

final class ProfileViewController: UIViewController {
    
    private let profilePresenter : ProfilePresenterProtocol!
    private let profileView : ProfileViewProtocol!
    
    private let leftBarButton : UIBarButtonItem = {
        $0.tintColor = .white
        return $0
    }(UIBarButtonItem(
        image: UIImage(systemName: "gear"),
        style: .plain,
        target: ProfileViewController.self,
        action: #selector(onSettingsTouched)
    ))
    
    private let rightBarButton : UIBarButtonItem = {
        $0.tintColor = .white
        return $0
    }(UIBarButtonItem(
        image: UIImage(systemName: "square.and.pencil"),
        style: .plain,
        target: ProfileViewController.self,
        action: #selector(onNotesTouched)
    ))
    
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
        
//        navigationItem.leftBarButtonItem = UIBarButtonItem(
//            image: UIImage(systemName: "gear"),
//            style: .plain,
//            target: self,
//            action: #selector(onSettingsTouched))
//        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(
//            image: UIImage(systemName: "square.and.pencil"),
//            style: .plain,
//            target: self,
//            action: #selector(onNotesTouched))
        
        navigationItem.leftBarButtonItem = leftBarButton
        navigationItem.rightBarButtonItem = rightBarButton
        
        view.addSubview(profileView)
    }
}

private extension ProfileViewController {
    @objc private func onSettingsTouched() {
        print("settings")
    }
    
    @objc private func onNotesTouched() {
        print("notes")
    }
}

extension ProfileViewController : ProfileViewControllerProtocol { }
