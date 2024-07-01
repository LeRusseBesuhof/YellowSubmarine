import UIKit

protocol ProfileViewControllerProtocol : ViewControllerProtocol {
    func presentPickerController(_ picker: UIImagePickerController)
}

final class ProfileViewController: UIViewController {
    
    private let presenter : ProfilePresenterProtocol!
    private let pView : ProfileViewProtocol!
    
    struct Dependencies {
        let presenter : ProfilePresenterProtocol
    }
    
    init(dependencies: Dependencies) {
        self.presenter = dependencies.presenter
        self.pView = ProfileView(frame: UIScreen.main.bounds)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.presenter.loadView(controller: self, view: pView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationItem()
        view.addSubview(pView)
    }
}

private extension ProfileViewController {
    private func setUpNavigationItem() {
        let leftBarButton : UIBarButtonItem = {
            $0.tintColor = .white
            return $0
        }(UIBarButtonItem(
            image: UIImage(systemName: "gear"),
            style: .plain,
            target: self,
            action: #selector(onSettingsTouched)
        ))
        
        let rightBarButton : UIBarButtonItem = {
            $0.tintColor = .white
            return $0
        }(UIBarButtonItem(
            image: UIImage(systemName: "square.and.pencil"),
            style: .plain,
            target: self,
            action: #selector(onNotesTouched)
        ))
        
        navigationItem.leftBarButtonItem = leftBarButton
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc private func onSettingsTouched() {
        let settingsController = SettingsAssembly.build(presenter)
        navigationController?.pushViewController(settingsController, animated: true)
    }
    
    @objc private func onNotesTouched() {
        let noteController = ListAssemby.build()
        navigationController?.pushViewController(noteController, animated: true)
    }
}

extension ProfileViewController : ProfileViewControllerProtocol {
    func presentPickerController(_ picker: UIImagePickerController) {
        self.present(picker, animated: true)
    }
}
