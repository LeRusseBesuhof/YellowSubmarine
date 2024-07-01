import UIKit

protocol CreationViewControllerProtocol : ViewControllerProtocol {
    func presentPickerController(_ picker: UIImagePickerController)
}

final class CreationViewController: UIViewController {
    private let cView : CreationViewProtocol!
    private let presenter : CreationPresenterProtocol!
    
    struct Dependencies {
        let presenter : CreationPresenterProtocol
    }
    
    init(dependencies: Dependencies) {
        self.cView = CreationView(frame: UIScreen.main.bounds)
        self.presenter = dependencies.presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        presenter.loadView(view: cView, controller: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(cView)
    }
    
}

extension CreationViewController : CreationViewControllerProtocol {
    
    func presentPickerController(_ picker: UIImagePickerController) {
        self.present(picker, animated: true)
    }
}
