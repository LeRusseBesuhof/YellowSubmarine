import UIKit

protocol PersonViewProtocol : UIImageView {
    var sendDate: (() -> Void)? { get set }
    
    func getPersonData() -> PersonData
}

final class PersonView: UIImageView {
    
    var sendDate: (() -> Void)?
    
    private lazy var personLabel = AppUI.createLabel(
        withText: "Personal\nInformation",
        textColor: .appBrown,
        font: .getAmitaFont(fontType: .bold, fontSize: 50),
        alignment: .left
    )
    
    private lazy var profileButton : UIButton = {
        .config(view: UIButton()) {
            $0.setImage(UIImage(systemName: "photo"), for: .normal)
            $0.tintColor = .appBrown
        }
    }()
    
    private lazy var profileView : UIView = {
        .config(view: UIView()) { [weak self] in
            guard let self = self else { return }
            $0.layer.cornerRadius = 50
            $0.backgroundColor = .white
            $0.layer.borderColor = UIColor.appBrown.cgColor
            $0.layer.borderWidth = 4
            $0.clipsToBounds = true
            $0.addSubview(profileButton)
            
            NSLayoutConstraint.activate([
                profileButton.leadingAnchor.constraint(equalTo: $0.leadingAnchor),
                profileButton.topAnchor.constraint(equalTo: $0.topAnchor),
                profileButton.trailingAnchor.constraint(equalTo: $0.trailingAnchor),
                profileButton.bottomAnchor.constraint(equalTo: $0.bottomAnchor),
            ])
        }
    }()
    
    private lazy var nameLabel = AppUI.createLabel(
        withText: "Enter your name:",
        textColor: .appOrange,
        font: .getMeriendaFont(fontSize: 24),
        alignment: .left
    )
    
    private lazy var nameTextField = AppUI.createTextField(
        withPlaceholder: "",
        placeholderColor: .appPlaceholder,
        bgColor: .appLightYellow,
        font: .getMontserratFont(fontSize: 16),
        textColor: .appBrown,
        leftViewPic: "highlighter",
        cornerRadius: 20)
    
    private lazy var genderLabel : UILabel = AppUI.createLabel(
        withText: "Choose your gender:",
        textColor: .appOrange,
        font: .getMeriendaFont(fontSize: 24),
        alignment: .left
    )
    
    private lazy var genderSegmentControl : UISegmentedControl = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.insertSegment(withTitle: "Male", at: 0, animated: true)
        $0.insertSegment(withTitle: "Female", at: 1, animated: true)
        $0.selectedSegmentIndex = 0
        $0.backgroundColor = .appLightYellow
        $0.selectedSegmentTintColor = .appLightBrown
        $0.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.appBrown], for: .normal)
        $0.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white], for: .selected)
        return $0
    }(UISegmentedControl())
    
    private lazy var birthdayLabel : UILabel = AppUI.createLabel(
        withText: "Set your Birthday:",
        textColor: .appOrange,
        font: .getMeriendaFont(fontSize: 24),
        alignment: .left)
    
    private lazy var datePicker : UIDatePicker = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.datePickerMode = .date
        $0.preferredDatePickerStyle = .compact
        $0.minimumDate = createDate(day: 1, month: 1, year: 1924)
        $0.maximumDate = Date.now
        $0.date = Date.now
        $0.backgroundColor = .appLightYellow
        $0.tintColor = .red
        return $0
    }(UIDatePicker())
    
    private lazy var dateView : UIView = {
        .config(view: UIView()) { [weak self] in
            guard let self = self else { return }
            $0.layer.cornerRadius = 20
            $0.backgroundColor = .appLightYellow
            $0.addSubview(datePicker)
            
            NSLayoutConstraint.activate([
                datePicker.centerXAnchor.constraint(equalTo: $0.centerXAnchor),
                datePicker.centerYAnchor.constraint(equalTo: $0.centerYAnchor),
            ])
        }
    }()
    
    private lazy var sendButton : UIButton = {
        .config(view: UIButton()) { [weak self] in
            guard let self = self else { return }
            $0.setImage(.regMarine, for: .normal)
            $0.addTarget(self, action: #selector(onSendDateTouched), for: .touchDown)
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

private extension PersonView {
    
    private func createDate(day: Int, month: Int, year: Int) -> Date {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        
        let date = calendar.date(from: dateComponents)
        return date ?? Date.now
    }
    
    private func setUpView() {
        image = .background
        isUserInteractionEnabled = true
        
        addSubviews(personLabel, profileView, nameLabel, nameTextField, genderLabel, genderSegmentControl, birthdayLabel, dateView, sendButton)
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            personLabel.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            personLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            personLabel.widthAnchor.constraint(equalToConstant: 300),
            
            profileView.topAnchor.constraint(equalTo: personLabel.topAnchor),
            profileView.centerXAnchor.constraint(equalTo: personLabel.trailingAnchor, constant: -20),
            profileView.widthAnchor.constraint(equalToConstant: 100),
            profileView.heightAnchor.constraint(equalToConstant: 100),
            
            nameLabel.topAnchor.constraint(equalTo: personLabel.bottomAnchor, constant: 30),
            nameLabel.leadingAnchor.constraint(equalTo: personLabel.leadingAnchor),
            
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            nameTextField.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            nameTextField.widthAnchor.constraint(equalToConstant: 280),
            nameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            genderLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 40),
            genderLabel.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            
            genderSegmentControl.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 20),
            genderSegmentControl.leadingAnchor.constraint(equalTo: genderLabel.leadingAnchor, constant: 20),
            genderSegmentControl.widthAnchor.constraint(equalToConstant: 250),
            genderSegmentControl.heightAnchor.constraint(equalToConstant: 40),
            
            birthdayLabel.topAnchor.constraint(equalTo: genderSegmentControl.bottomAnchor, constant: 40),
            birthdayLabel.leadingAnchor.constraint(equalTo: genderSegmentControl.leadingAnchor, constant: 30),
            
            dateView.topAnchor.constraint(equalTo: birthdayLabel.bottomAnchor, constant: 20),
            dateView.centerXAnchor.constraint(equalTo: birthdayLabel.centerXAnchor),
            dateView.widthAnchor.constraint(equalToConstant: 140),
            dateView.heightAnchor.constraint(equalToConstant: 50),

            sendButton.topAnchor.constraint(equalTo: dateView.bottomAnchor, constant: 30),
            sendButton.centerXAnchor.constraint(equalTo: dateView.trailingAnchor),
            sendButton.widthAnchor.constraint(equalToConstant: 85),
            sendButton.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    @objc private func onSendDateTouched() {
        self.sendDate?()
    }
}

extension PersonView : PersonViewProtocol {
    func getPersonData() -> PersonData {
        PersonData(
            name: nameTextField.text ?? .simpleNickname,
            gender: genderSegmentControl.titleForSegment(at: genderSegmentControl.selectedSegmentIndex) ?? .simpleGender,
            birthday: datePicker.date)
    }
}
