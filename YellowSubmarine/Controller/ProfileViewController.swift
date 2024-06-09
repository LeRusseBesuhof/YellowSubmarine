import UIKit

class ProfileViewController: UIViewController {

    private lazy var canvasImageView : UIImageView = AppUI.createCanvasImageView(image: .background)
    
    private lazy var accessLabel : UILabel = AppUI.createLabel(
        withText: "Access Allowed!",
        textColor: .appOrange,
        font: UIFont.systemFont(ofSize: 52, weight: .bold), 
        alignment: .left,
        isUnderlined: true)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        activateConstraints()
    }
    
    private func setUpView() {
        canvasImageView.addSubview(accessLabel)
        canvasImageView.frame = view.frame
        view.addSubview(canvasImageView)
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            accessLabel.topAnchor.constraint(equalTo: canvasImageView.topAnchor, constant: 250),
            accessLabel.leadingAnchor.constraint(equalTo: canvasImageView.leadingAnchor, constant: 50),
            accessLabel.widthAnchor.constraint(equalToConstant: 200),
            accessLabel.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
}
