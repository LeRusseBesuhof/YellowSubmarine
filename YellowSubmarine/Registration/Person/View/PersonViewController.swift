import UIKit

protocol PersonViewControllerProtocol : ViewControllerProtocol {
    func presentPickerController(_ picker: UIImagePickerController)
}

final class PersonViewController: UIViewController {

    private let piew : PersonViewProtocol!
    private let presenter : PersonPresenterProtocol!
    
    internal var chooseImage : (() -> Void)?
    
    struct Dependencies {
        let presenter : PersonPresenterProtocol
    }
    
    init(dependencies: Dependencies) {
        self.piew = PersonView(frame: UIScreen.main.bounds)
        self.presenter = dependencies.presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.presenter.loadView(controller: self, view: piew)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(piew)
    }
    
}

extension PersonViewController : PersonViewControllerProtocol {
    func presentPickerController(_ picker: UIImagePickerController) {
        self.present(picker, animated: true)
    }
}
