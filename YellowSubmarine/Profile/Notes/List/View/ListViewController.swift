import UIKit

protocol ListViewControllerProtocol : ViewControllerProtocol {
    
}

final class ListViewController: UIViewController {
    private let listView : ListViewProtocol!
    private let listPresenter : ListPresenter!
    
    struct Dependencies {
        let presenter : ListPresenter
    }
    
    init(dependencies: Dependencies) {
        self.listView = ListView(frame: UIScreen.main.bounds)
        self.listPresenter = dependencies.presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.listPresenter.loadView(view: listView, controller: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        view.addSubview(listView)
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
    
}
