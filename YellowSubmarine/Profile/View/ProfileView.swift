import UIKit

protocol ProfileViewProtocol : UIImageView {
    var currentUserData : ProfileFields! { get set }
}

final class ProfileView: UIImageView {
    
    internal var currentUserData : ProfileFields!
    
    private lazy var nickLabel : UILabel = AppUI.createLabel(
        withText: currentUserData.nick,
        textColor: .white,
        font: .getAmitaFont(fontSize: 28),
        alignment: .center)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        activateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ProfileView {
    
    private func setUpView() {
        image = .profileBack
        isUserInteractionEnabled = true
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            
        ])
    }
}

extension ProfileView : ProfileViewProtocol {
    
}
