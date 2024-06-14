import UIKit

protocol RegisterViewProtocol : UIImageView {
    var goToAuthHandler: (() -> Void)? { get set }
    var regAndGoToAuthHandler: (() -> Void)? { get set }
    
    func getUserRegData() -> UserRegData
}

final class RegisterView: UIImageView {
    
    internal var goToAuthHandler: (() -> Void)?
    internal var regAndGoToAuthHandler: (() -> Void)?

    // private lazy var canvasImageView : UIImageView = AppUI.createCanvasImageView(image: .background)
    
    private lazy var registerLabel : UILabel = AppUI.createLabel(
        withText: "Register",
        textColor: .appBrown,
        font: .getAmitaFont(fontType: .bold, fontSize: 50),
        alignment: .center,
        isUnderlined: false
    )
    
    private lazy var nicknameTextField : UITextField = AppUI.createTextField(
        withPlaceholder: "Nickname",
        placeholderColor: .appPlaceholder,
        bgColor: .appLightYellow,
        font: UIFont.getMontserratFont(fontSize: 16),
        textColor: .appBrown,
        leftViewPic: "person",
        cornerRadius: 20
    )
    
    private lazy var emailTextField : UITextField = AppUI.createTextField(
        withPlaceholder: "Email",
        placeholderColor: .appPlaceholder,
        bgColor: .appLightYellow,
        font: UIFont.getMontserratFont(fontSize: 16),
        textColor: .appBrown,
        leftViewPic: "envelope",
        cornerRadius: 20
    )
    
    private lazy var passwordTextField : UITextField = AppUI.createTextField(
        withPlaceholder: "Password",
        placeholderColor: .appPlaceholder,
        bgColor: .appLightYellow,
        font: UIFont.getMontserratFont(fontSize: 16),
        textColor: .appBrown,
        leftViewPic: "lock",
        cornerRadius: 20
    )
    
    private lazy var textFieldsStack : UIStackView = {
        .config(view: UIStackView()) { [weak self] st in
            guard let self = self else { return }
            st.spacing = 15
            st.alignment = .fill
            st.axis = .vertical
            st.distribution = .fillEqually
            [nicknameTextField, emailTextField, passwordTextField].forEach { st.addArrangedSubview($0) }
        }
    }()
    
    private lazy var regButton : UIButton = {
        .config(view: UIButton()) { [weak self] in
            guard let self = self else { return }
            $0.setImage(.regMarine, for: .normal)
            $0.addTarget(self, action: #selector(onRegTouched), for: .touchDown)
        }
    }()
    
    private lazy var loginButton : UIButton = {
        .config(view: UIButton()) { [weak self] in
            guard let self = self else { return }
            let title = String.getUnderlinedString("Login")
            $0.setAttributedTitle(title, for: .normal)
            $0.setTitleColor(.appOrange, for: .normal)
            $0.titleLabel?.font = UIFont.getMeriendaFont(fontSize: 28)
            $0.addTarget(self, action: #selector(onLoginTouched), for: .touchDown)
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

private extension RegisterView {
    
    private func setUpView() {
        image = .background
        isUserInteractionEnabled = true
        addSubviews(registerLabel, textFieldsStack, regButton, loginButton)
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            registerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 250),
            registerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            registerLabel.heightAnchor.constraint(equalToConstant: 60),
            
            textFieldsStack.topAnchor.constraint(equalTo: registerLabel.bottomAnchor, constant: 40),
            textFieldsStack.leadingAnchor.constraint(equalTo: registerLabel.leadingAnchor),
            textFieldsStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -100),
            textFieldsStack.heightAnchor.constraint(equalToConstant: 180),
            
            regButton.topAnchor.constraint(equalTo: textFieldsStack.bottomAnchor, constant: 40),
            regButton.leadingAnchor.constraint(equalTo: textFieldsStack.centerXAnchor, constant: 60),
            regButton.widthAnchor.constraint(equalToConstant: 85),
            regButton.heightAnchor.constraint(equalToConstant: 80),
            
            loginButton.topAnchor.constraint(equalTo: regButton.bottomAnchor, constant: 35),
            loginButton.centerXAnchor.constraint(equalTo: regButton.leadingAnchor, constant: -20),
            loginButton.widthAnchor.constraint(equalToConstant: 80),
            loginButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc private func onRegTouched() {
        self.regAndGoToAuthHandler?()
    }
    
    @objc private func onLoginTouched() {
        self.goToAuthHandler?()
    }
}

extension RegisterView : RegisterViewProtocol {
    func getUserRegData() -> UserRegData {
        UserRegData(
            name: nicknameTextField.text ?? .simpleNickname,
            email: emailTextField.text ?? .simpleEmail,
            password: passwordTextField.text ?? .simplePassword
        )
    }
    
}
