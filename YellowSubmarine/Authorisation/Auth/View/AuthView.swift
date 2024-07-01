import UIKit

protocol AuthViewProtocol : UIImageView {
    var goToProfileHandler: (() -> Void)? { get set }
    var goToRegHandler: (() -> Void)? { get set }
    var goToPasswordChangeHandler: (() -> Void)? { get set }
    
    func setAuthUserData()
}

final class AuthView : UIImageView {
    internal var goToProfileHandler: (() -> Void)?
    internal var goToRegHandler: (() -> Void)?
    
    private lazy var loginLabel : UILabel = AppUI.createLabel(
        withText: "Login",
        textColor: .appBrown,
        font: .getAmitaFont(fontType: .bold, fontSize: 50),
        alignment: .center
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
            [emailTextField, passwordTextField].forEach { st.addArrangedSubview($0) }
        }
    }()
    
    private lazy var logButton : UIButton = {
        .config(view: UIButton()) { [weak self] in
            guard let self = self else { return }
            $0.setImage(.logMarine, for: .normal)
            $0.addTarget(self, action: #selector(onLoginTouched), for: .touchDown)
        }
    }()
    
    private lazy var regButton : UIButton = {
        .config(view: UIButton()) { [weak self] in
            guard let self = self else { return }
            let title = String.getUnderlinedString("Register")
            $0.setAttributedTitle(title, for: .normal)
            $0.setTitleColor(.appOrange, for: .normal)
            $0.titleLabel?.font = UIFont.getMeriendaFont(fontSize: 28)
            $0.addTarget(self, action: #selector(onRegTouched), for: .touchDown)
        }
    }()
    
    internal var goToPasswordChangeHandler: (() -> Void)?
    
    private lazy var changePassButton : UIButton = {
        .config(view: UIButton()) { [weak self] in
            guard let self = self else { return }
            
            let attributes : [NSAttributedString.Key : Any] = [
                .foregroundColor: UIColor.appPlaceholder,
                .font: UIFont.getMontserratFont(fontSize: 14),
                .underlineStyle: NSUnderlineStyle.single.rawValue,
                .underlineColor: UIColor.appPlaceholder
            ]
            
            let attributedTitle = NSAttributedString(string: "* forgot your password?", attributes: attributes)
            
            $0.setAttributedTitle(attributedTitle, for: .normal)
            $0.addTarget(self, action: #selector(onPassTouched), for: .touchDown)
        }
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpView()
        self.activateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension AuthView {
    
    private func setUpView() {
        self.image = .background
        self.isUserInteractionEnabled = true
        addSubviews(loginLabel, textFieldsStack, changePassButton, logButton, regButton)
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            loginLabel.topAnchor.constraint(equalTo: topAnchor, constant: 250),
            loginLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            loginLabel.heightAnchor.constraint(equalToConstant: 60),
            
            textFieldsStack.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 40),
            textFieldsStack.leadingAnchor.constraint(equalTo: loginLabel.leadingAnchor),
            textFieldsStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -100),
            textFieldsStack.heightAnchor.constraint(equalToConstant: 120),
            
            changePassButton.topAnchor.constraint(equalTo: textFieldsStack.bottomAnchor, constant: 10),
            changePassButton.leadingAnchor.constraint(equalTo: textFieldsStack.leadingAnchor),
            changePassButton.trailingAnchor.constraint(equalTo: textFieldsStack.trailingAnchor),
            
            logButton.topAnchor.constraint(equalTo: textFieldsStack.bottomAnchor, constant: 100),
            logButton.leadingAnchor.constraint(equalTo: textFieldsStack.centerXAnchor, constant: 60),
            logButton.widthAnchor.constraint(equalToConstant: 85),
            logButton.heightAnchor.constraint(equalToConstant: 80),
            
            regButton.topAnchor.constraint(equalTo: logButton.bottomAnchor, constant: 35),
            regButton.centerXAnchor.constraint(equalTo: logButton.leadingAnchor, constant: -20),
            regButton.widthAnchor.constraint(equalToConstant: 120),
            regButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc private func onLoginTouched() {
        self.goToProfileHandler?()
    }
    
    @objc private func onRegTouched() {
        self.goToRegHandler?()
    }
    
    @objc private func onPassTouched() {
        self.goToPasswordChangeHandler?()
    }
}

extension AuthView : AuthViewProtocol {
    func setAuthUserData() {
        UserData.email = emailTextField.text ?? ""
        UserData.password = passwordTextField.text ?? ""
    }
}
