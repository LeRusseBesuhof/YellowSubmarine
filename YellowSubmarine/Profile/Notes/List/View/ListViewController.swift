import UIKit

protocol ListViewControllerProtocol : ViewControllerProtocol {
    func presentNote(_ note: UIViewController)
}

final class ListViewController: UIViewController {
    private let lView : ListViewProtocol!
    private let presenter : ListPresenter!
    
    struct Dependencies {
        let presenter : ListPresenter
    }
    
    init(dependencies: Dependencies) {
        self.lView = ListView(frame: UIScreen.main.bounds)
        self.presenter = dependencies.presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.presenter.loadView(view: lView, controller: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        view.addSubview(lView)
    }
}

private extension ListViewController {
    func setUpNavigationBar() {
        let logOutBarButton = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            primaryAction: UIAction { [weak self] _ in
                guard let self = self else { return }
                
                let creationVC = CreationAssembly.build()
                present(creationVC, animated: true)
            }
        )
        
        navigationItem.rightBarButtonItem = logOutBarButton
        navigationController?.navigationBar.tintColor = .white
    }
}

extension ListViewController : ListViewControllerProtocol {
    func presentNote(_ note: UIViewController) {
        self.present(note, animated: true)
    }
}
