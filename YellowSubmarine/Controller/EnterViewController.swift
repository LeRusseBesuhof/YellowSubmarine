import UIKit

final class EnterViewController: UIViewController {

    private lazy var canvasImageView : UIImageView = AppUI.createCanvasImageView(image: .background)
    
    private lazy var loginLabel : UILabel = AppUI.createLabel(
        withText: "Login",
        textColor: .appBrown,
        font: .systemFont(ofSize: 50, weight: .bold),
        alignment: .center,
        isUnderlined: false
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
            [emailTextField, passwordTextField].forEach { st.addArrangedSubview($0) }
        }
    }()
    
    private lazy var logButton : UIButton = {
        .config(view: UIButton()) { [weak self] in
            guard let self = self else { return }
            $0.setImage(.submarine, for: .normal)
            $0.addAction(logButtonAction, for: .touchUpInside)
        }
    }()
    
    private lazy var logButtonAction = UIAction { _ in
        NotificationCenter.default.post(Notification(name: Notification.Name(.setRoot), object: EnterViewController()))
    }
    
    private lazy var regButton : UIButton = {
        .config(view: UIButton()) { [weak self] in
            guard let self = self else { return }
            let title = String.getUnderlinedString("Register")
            $0.setAttributedTitle(title, for: .normal)
            $0.setTitleColor(.appOrange, for: .normal)
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 28)
            $0.addAction(regButtonAction, for: .touchUpInside)
        }
    }()
    
    private lazy var regButtonAction = UIAction { _ in
        NotificationCenter.default.post(Notification(name: Notification.Name(.setRoot), object: RegisterViewController()))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        activateConstraints()
    }
    
    private func setUpView() {
        [loginLabel, textFieldsStack, logButton, regButton].forEach { canvasImageView.addSubview($0) }
        canvasImageView.frame = view.frame
        view.addSubview(canvasImageView)
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            loginLabel.topAnchor.constraint(equalTo: canvasImageView.topAnchor, constant: 250),
            loginLabel.leadingAnchor.constraint(equalTo: canvasImageView.leadingAnchor, constant: 50),
            
            textFieldsStack.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 40),
            textFieldsStack.leadingAnchor.constraint(equalTo: loginLabel.leadingAnchor),
            textFieldsStack.trailingAnchor.constraint(equalTo: canvasImageView.trailingAnchor, constant: -100),
            textFieldsStack.heightAnchor.constraint(equalToConstant: 120),
            
            logButton.topAnchor.constraint(equalTo: textFieldsStack.bottomAnchor, constant: 100),
            logButton.leadingAnchor.constraint(equalTo: textFieldsStack.centerXAnchor, constant: 60),
            logButton.widthAnchor.constraint(equalToConstant: 95),
            logButton.heightAnchor.constraint(equalToConstant: 50),
            
            regButton.topAnchor.constraint(equalTo: logButton.bottomAnchor, constant: 50),
            regButton.centerXAnchor.constraint(equalTo: logButton.leadingAnchor, constant: -20),
            regButton.widthAnchor.constraint(equalToConstant: 120),
            regButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
