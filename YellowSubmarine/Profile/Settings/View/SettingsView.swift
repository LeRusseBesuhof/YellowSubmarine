import Foundation
import UIKit

protocol SettingsViewProtocol : UIImageView {
    var saveChanges: (([String: String]) -> Void)? { get set }
}

final class SettingsView : UIImageView {
    
    internal var saveChanges: (([String: String]) -> Void)?
    
    private lazy var canvasView : UIView = {
        .config(view: UIView()) {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 50
        }
    }()
    
    private lazy var nickLabel = AppUI.createLabel(
        withText: "Your nickname:",
        textColor: .black,
        font: .getMontserratFont(fontSize: 18),
        alignment: .left
    )
    
    private lazy var nickTextField = AppUI.createTextField(
        withPlaceholder: UserData.nick,
        placeholderColor: .appPlaceholder,
        bgColor: .appLightGray,
        font: .getMontserratFont(fontSize: 14),
        textColor: .appBrown,
        leftViewPic: "highlighter",
        cornerRadius: 20
    )
    
    private lazy var nickStack : UIStackView = AppUI.createStack(
        label: nickLabel,
        textField: nickTextField
    )
    
    private lazy var educationLabel = AppUI.createLabel(
        withText: "Your education:",
        textColor: .black,
        font: .getMontserratFont(fontSize: 18),
        alignment: .left
    )
    
    private lazy var educationTextField = AppUI.createTextField(
        withPlaceholder: UserData.education,
        placeholderColor: .appPlaceholder,
        bgColor: .appLightGray,
        font: .getMontserratFont(fontSize: 14),
        textColor: .appBrown,
        leftViewPic: "highlighter",
        cornerRadius: 20
    )
    
    private lazy var educationStack : UIStackView = AppUI.createStack(
        label: educationLabel,
        textField: educationTextField
    )
    
    private lazy var professionLabel = AppUI.createLabel(
        withText: "Your profession:",
        textColor: .black,
        font: .getMontserratFont(fontSize: 18),
        alignment: .left
    )
    
    private lazy var professionTextField = AppUI.createTextField(
        withPlaceholder: UserData.profession,
        placeholderColor: .appPlaceholder,
        bgColor: .appLightGray,
        font: .getMontserratFont(fontSize: 14),
        textColor: .appBrown,
        leftViewPic: "highlighter",
        cornerRadius: 20
    )
    
    private lazy var professionStack : UIStackView = AppUI.createStack(
        label: professionLabel,
        textField: professionTextField
    )
    
    private lazy var hobbiesLabel = AppUI.createLabel(
        withText: "Your hobbies:",
        textColor: .black,
        font: .getMontserratFont(fontSize: 18),
        alignment: .left
    )
    
    private lazy var hobbiesTextField = AppUI.createTextField(
        withPlaceholder: UserData.hobbies,
        placeholderColor: .appPlaceholder,
        bgColor: .appLightGray,
        font: .getMontserratFont(fontSize: 14),
        textColor: .appBrown,
        leftViewPic: "highlighter",
        cornerRadius: 20
    )
    
    private lazy var hobbiesStack : UIStackView = AppUI.createStack(
        label: hobbiesLabel,
        textField: hobbiesTextField
    )
    
    private lazy var filmLabel = AppUI.createLabel(
        withText: "Your favorite films:",
        textColor: .black,
        font: .getMontserratFont(fontSize: 18),
        alignment: .left
    )
    
    private lazy var filmTextField = AppUI.createTextField(
        withPlaceholder: UserData.film,
        placeholderColor: .appPlaceholder,
        bgColor: .appLightGray,
        font: .getMontserratFont(fontSize: 14),
        textColor: .appBrown,
        leftViewPic: "highlighter",
        cornerRadius: 20
    )
    
    private lazy var filmStack : UIStackView = AppUI.createStack(
        label: filmLabel,
        textField: filmTextField
    )
    
    private lazy var giftLabel = AppUI.createLabel(
        withText: "Your wish list:",
        textColor: .black,
        font: .getMontserratFont(fontSize: 18),
        alignment: .left
    )
    
    private lazy var giftTextField = AppUI.createTextField(
        withPlaceholder: UserData.gift,
        placeholderColor: .appPlaceholder,
        bgColor: .appLightGray,
        font: .getMontserratFont(fontSize: 14),
        textColor: .appBrown,
        leftViewPic: "highlighter",
        cornerRadius: 20
    )
    
    private lazy var giftStack : UIStackView = AppUI.createStack(
        label: giftLabel,
        textField: giftTextField
    )
    
    private lazy var fieldsStack : UIStackView = {
        .config(view: UIStackView()) { [weak self] stack in
            guard let self = self else { return }
            
            stack.axis = .vertical
            stack.alignment = .fill
            stack.spacing = 10
            stack.distribution = .equalSpacing
            [nickStack, educationStack, professionStack, hobbiesStack, filmStack, giftStack].forEach {
                stack.addArrangedSubview($0)
            }
        }
    }()
    
    private lazy var saveButton : UIButton = {
        .config(view: UIButton()) { [weak self] in
            guard let self = self else { return }
            
            $0.layer.cornerRadius = 30
            $0.backgroundColor = .white
            $0.setTitle("Save changes", for: .normal)
            $0.setTitleColor(.appBrown, for: .normal)
            $0.titleLabel?.font = .getMontserratFont(fontSize: 24)
            $0.addTarget(self, action: #selector(onSaveChangesTouched), for: .touchDown)
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

private extension SettingsView {
    private func setUpView() {
        image = .backMerged
        isUserInteractionEnabled = true
        
        canvasView.addSubviews(fieldsStack)
        addSubviews(canvasView, saveButton)
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            canvasView.topAnchor.constraint(equalTo: topAnchor, constant: 120),
            canvasView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            canvasView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            canvasView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -150),
            
            nickTextField.heightAnchor.constraint(equalToConstant: 40),
            educationTextField.heightAnchor.constraint(equalToConstant: 40),
            professionTextField.heightAnchor.constraint(equalToConstant: 40),
            hobbiesTextField.heightAnchor.constraint(equalToConstant: 40),
            filmTextField.heightAnchor.constraint(equalToConstant: 40),
            giftTextField.heightAnchor.constraint(equalToConstant: 40),
            
            fieldsStack.topAnchor.constraint(equalTo: canvasView.topAnchor, constant: 30),
            fieldsStack.leadingAnchor.constraint(equalTo: canvasView.leadingAnchor, constant: 20),
            fieldsStack.trailingAnchor.constraint(equalTo: canvasView.trailingAnchor, constant: -20),
            fieldsStack.bottomAnchor.constraint(equalTo: canvasView.bottomAnchor, constant: -30),

            saveButton.topAnchor.constraint(equalTo: canvasView.bottomAnchor, constant: 25),
            saveButton.leadingAnchor.constraint(equalTo: canvasView.leadingAnchor),
            saveButton.trailingAnchor.constraint(equalTo: canvasView.trailingAnchor),
            saveButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -60)
        ])
    }
    
    @objc private func onSaveChangesTouched() {
        print("changes")
        var dictOfChanges = [String: String]()
        
        if let nick = nickTextField.text, nick != "" {
            dictOfChanges[.nick] = nick
        }
        if let edu = educationTextField.text, edu != "" {
            dictOfChanges[.edu] = edu
        }
        if let prof = professionTextField.text, prof != "" {
            dictOfChanges[.prof] = prof
        }
        if let hobby = hobbiesTextField.text, hobby != "" {
            dictOfChanges[.hobbies] = hobby
        }
        if let film = filmTextField.text, film != "" {
            dictOfChanges[.films] = film
        }
        if let gift = giftTextField.text, gift != "" {
            dictOfChanges[.gift] = gift
        }
        
        self.saveChanges?(dictOfChanges)
    }
}

extension SettingsView : SettingsViewProtocol {
    
}
