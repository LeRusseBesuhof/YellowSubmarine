import UIKit

protocol NoteViewControllerProtocol : ViewControllerProtocol {
    
}

final class NoteViewController: UIViewController {
    private let noteView : NoteViewProtocol!
    private let notePresenter : NotePresenter!
    
    struct Dependencies {
        let presenter : NotePresenter
    }
    
    init(dependencies: Dependencies) {
        self.noteView = NoteView(frame: UIScreen.main.bounds)
        self.notePresenter = dependencies.presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.notePresenter.loadView(view: noteView, controller: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        view.addSubview(noteView)
    }
}

private extension NoteViewController {
    func setUpNavigationBar() {
        let logOutBarButton = UIBarButtonItem(
            title: "Create Note",
            primaryAction: UIAction { [weak self] _ in
                guard let self = self else { return }
                
                
                // code
            }
        )
        
        navigationItem.rightBarButtonItem = logOutBarButton
        navigationController?.navigationBar.tintColor = .white
        
        title = "Settings"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}

extension NoteViewController : NoteViewControllerProtocol {
    
}
