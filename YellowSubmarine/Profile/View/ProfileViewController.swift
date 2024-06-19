import UIKit

protocol ProfileViewControllerProtocol : ViewControllerProtocol { }

final class ProfileViewController: UIViewController {
    
    private let loginModel : LoginModel = LoginModel()

    private lazy var canvasImageView : UIImageView = AppUI.createCanvasImageView(image: .background)
    
    private lazy var accessLabel : UILabel = AppUI.createLabel(
        withText: "Access Allowed!",
        textColor: .appYellow,
        font: UIFont.systemFont(ofSize: 52, weight: .bold),
        alignment: .left,
        isUnderlined: true)
    
    private lazy var exitButton : UIButton = {
        .config(view: UIButton()) { [weak self] in
            guard let self = self else { return }
            $0.setTitle("Exit", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 48, weight: .bold)
            $0.backgroundColor = .appOrange
            $0.layer.cornerRadius = 20
            $0.addAction(exitButtonAction, for: .touchUpInside)
        }
    }()
    
    private lazy var exitButtonAction : UIAction = UIAction { [weak self] _ in
        guard let self = self else { return }
        loginModel.logOut()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        activateConstraints()
    }
    
    private func setUpView() {
        canvasImageView.addSubviews(accessLabel, exitButton)
        canvasImageView.frame = view.frame
        view.addSubview(canvasImageView)
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            accessLabel.topAnchor.constraint(equalTo: canvasImageView.topAnchor, constant: 250),
            accessLabel.leadingAnchor.constraint(equalTo: canvasImageView.leadingAnchor, constant: 50),
            accessLabel.widthAnchor.constraint(equalToConstant: 220),
            accessLabel.heightAnchor.constraint(equalToConstant: 200),
            
            exitButton.topAnchor.constraint(equalTo: accessLabel.bottomAnchor, constant: 100),
            exitButton.centerXAnchor.constraint(equalTo: accessLabel.trailingAnchor),
            exitButton.widthAnchor.constraint(equalToConstant: 150),
            exitButton.heightAnchor.constraint(equalToConstant: 90)
        ])
    }
}

extension ProfileViewController : ProfileViewControllerProtocol { }
