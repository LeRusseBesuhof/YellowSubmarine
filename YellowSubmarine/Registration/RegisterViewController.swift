import UIKit

final class RegisterViewController: UIViewController {
    
    private let registerModel : RegistrationModel = RegistrationModel()
    
    private lazy var userRegData : UserRegData = registerModel.setUserRegData(
        name: nicknameTextField.text ?? "simple nickname",
        email: emailTextField.text ?? "simple email",
        password: passwordTextField.text ?? "simple password"
    )

    private lazy var canvasImageView : UIImageView = AppUI.createCanvasImageView(image: .background)
    
    private lazy var registerLabel : UILabel = AppUI.createLabel(
        withText: "Register", 
        textColor: .appBrown,
        font: .systemFont(ofSize: 50, weight: .bold),
        alignment: .center,
        isUnderlined: false
    )
    
    private lazy var nicknameTextField : UITextField = AppUI.createTextField(
        withPlaceholder: "Nickname",
        bgColor: .appLightYellow,
        textColor: .appPlaceholder,
        leftViewPic: "person",
        cornerRadius: 20
    )
    
    private lazy var emailTextField : UITextField = AppUI.createTextField(
        withPlaceholder: "Email",
        bgColor: .appLightYellow,
        textColor: .appPlaceholder,
        leftViewPic: "envelope",
        cornerRadius: 20
    )
    
    private lazy var passwordTextField : UITextField = AppUI.createTextField(
        withPlaceholder: "Password",
        bgColor: .appLightYellow,
        textColor: .appPlaceholder,
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
            $0.addAction(regButtonAction, for: .touchUpInside)
        }
    }()
    
    private lazy var regButtonAction = UIAction { [weak self] _ in
        guard let self = self else { return }
        
        registerModel.userRegistration(userData: userRegData) { result in
            switch result {
            case .success(let success):
                if success { 
                    NotificationCenter.default.post(Notification(name: Notification.Name(.setRoot), object: EnterViewController()))
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    private lazy var loginButton : UIButton = {
        .config(view: UIButton()) { [weak self] in
            guard let self = self else { return }
            let title = String.getUnderlinedString("Login")
            $0.setAttributedTitle(title, for: .normal)
            $0.setTitleColor(.appOrange, for: .normal)
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 28)
            $0.addAction(logButtonAction, for: .touchUpInside)
        }
    }()
    
    private lazy var logButtonAction = UIAction { _ in
        NotificationCenter.default.post(Notification(name: Notification.Name(.setRoot), object: EnterViewController()))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        activateConstraints()
    }
    
    private func setUpView() {
        [registerLabel, textFieldsStack, regButton, loginButton].forEach { canvasImageView.addSubview($0) }
        canvasImageView.frame = view.frame
        view.addSubview(canvasImageView)
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            registerLabel.topAnchor.constraint(equalTo: canvasImageView.topAnchor, constant: 250),
            registerLabel.leadingAnchor.constraint(equalTo: canvasImageView.leadingAnchor, constant: 50),
            
            textFieldsStack.topAnchor.constraint(equalTo: registerLabel.bottomAnchor, constant: 40),
            textFieldsStack.leadingAnchor.constraint(equalTo: registerLabel.leadingAnchor),
            textFieldsStack.trailingAnchor.constraint(equalTo: canvasImageView.trailingAnchor, constant: -100),
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
}

