import UIKit

protocol NoteViewControllerProtocol : ViewControllerProtocol {
    func presentPicker(_ picker: UIImagePickerController)
}

final class NoteViewController: UIViewController {
    private var presenter : NotePresenterProtocol!
    private var nView : NoteViewProtocol!
    
    struct Dependencies {
        let presenter : NotePresenterProtocol
    }
    
    init(dependencies: Dependencies) {
        self.presenter = dependencies.presenter
        self.nView = NoteView(frame: UIScreen.main.bounds)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(nView)
    }
    
    override func loadView() {
        super.loadView()
        presenter.loadView(view: nView, controller: self)
    }
    
}

extension NoteViewController : NoteViewControllerProtocol {
    func presentPicker(_ picker: UIImagePickerController) {
        self.present(picker, animated: true)
    }
}
