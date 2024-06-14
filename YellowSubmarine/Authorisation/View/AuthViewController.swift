import UIKit

protocol AuthViewControllerProtocol : AnyObject {
    
}

final class AuthViewController: UIViewController {
    
//    init(<#parameters#>) {
//        
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
    }
}

extension AuthViewController : AuthViewControllerProtocol {
    
}
