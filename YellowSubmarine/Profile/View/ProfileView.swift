import UIKit

protocol ProfileViewProtocol : UIImageView {
    var currentUserData : ProfileFields! { get set }
    
    func updateData()
}

final class ProfileView: UIImageView {
    
    internal var currentUserData : ProfileFields!
    
    private lazy var nickLabel : UILabel = AppUI.createLabel(
        withText: "Wonderful girl",
        textColor: .white,
        font: .getAmitaFont(fontType: .bold, fontSize: 40),
        alignment: .center)
    
    private lazy var profileImage : UIImageView = AppUI.createImageView(
        image: .travelBlogger,
        tintColor: .appBrown,
        cornerRadius: 80,
        borderWidth: 6
    )
    
    private lazy var nameLabel : UILabel = AppUI.createLabel(
        withText: "Sabina",
        textColor: .black,
        font: .getAmitaFont(fontType: .bold, fontSize: 32),
        alignment: .center
    )
    
    private lazy var emailLabel : UILabel = AppUI.createLabel(
        withText: "default@gmail.com",
        textColor: .appPlaceholder,
        font: .getMontserratFont(fontSize: 18),
        alignment: .center
    )
    
    private lazy var canvasView : UIView = {
        .config(view: UIView()) {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 40
        }
    }()
    
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
        canvasView.addSubviews(profileImage, nameLabel, emailLabel)
        addSubviews(nickLabel, canvasView)
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            nickLabel.topAnchor.constraint(equalTo: topAnchor, constant: 90),
            nickLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            canvasView.topAnchor.constraint(equalTo: nickLabel.bottomAnchor, constant: 120),
            canvasView.leadingAnchor.constraint(equalTo: leadingAnchor),
            canvasView.trailingAnchor.constraint(equalTo: trailingAnchor),
            canvasView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            profileImage.topAnchor.constraint(equalTo: canvasView.topAnchor, constant: -80),
            profileImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            profileImage.widthAnchor.constraint(equalToConstant: 160),
            profileImage.heightAnchor.constraint(equalToConstant: 160),
            
            nameLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 15),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            emailLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            emailLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            
        ])
    }
}

extension ProfileView : ProfileViewProtocol {
    func updateData() {
        nickLabel.text = currentUserData.nick
        profileImage.image = UIImage(named: currentUserData.image)
        profileImage.contentMode = .scaleAspectFill
        nameLabel.text = currentUserData.name
    }
}
