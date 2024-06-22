import UIKit

protocol PersonViewProtocol : UIScrollView {
    var sendData: ((UIImage) -> Void)? { get set }
    var chooseProfilePicture: (() -> Void)? { get set }
    
    var imagePicker: UIImagePickerController { get set }
    
    func getPersonData(completion: (Result<Bool, FieldErrors>) -> Void)
}

final class PersonView: UIScrollView {
    
    // TODO: ADD SOME FIELDS LIKE JOB, EDUCATION, HOBBIES
    
    var sendData: ((UIImage) -> Void)?
    var chooseProfilePicture: (() -> Void)?
    
    private lazy var contentView : UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    private lazy var upContentImageView : UIImageView = {
        .config(view: UIImageView()) {
            $0.image = .background
            $0.isUserInteractionEnabled = true
        }
    }()
    
    private lazy var downContentImageView : UIImageView = {
        .config(view: UIImageView()) {
            $0.image = .backgroundDown
            $0.isUserInteractionEnabled = true
        }
    }()
    
    private lazy var personLabel = AppUI.createLabel(
        withText: "Personal\nInformation",
        textColor: .appBrown,
        font: .getAmitaFont(fontType: .bold, fontSize: 50),
        alignment: .left
    )
    
    private lazy var tapGest = UITapGestureRecognizer(target: self, action: #selector(onProfileImageViewTap))

    private lazy var profileImageView : UIImageView = AppUI.createImageView(
        image: .camera,
        tintColor: .appBrown,
        cornerRadius: 50,
        borderWidth: 4
    )
    
    internal lazy var imagePicker : UIImagePickerController = {
        $0.delegate = self
        $0.sourceType = .photoLibrary
        $0.allowsEditing = true
        return $0
    }(UIImagePickerController())
    
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
        cornerRadius: 20
    )
    
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
    
    private lazy var educationLabel : UILabel = AppUI.createLabel(
        withText: "Your education:",
        textColor: .appOrange,
        font: .getMeriendaFont(fontSize: 24),
        alignment: .left
    )
    
    private lazy var eduTextField = AppUI.createTextField(
        withPlaceholder: "",
        placeholderColor: .appPlaceholder,
        bgColor: .appLightYellow,
        font: .getMontserratFont(fontSize: 16),
        textColor: .appBrown,
        leftViewPic: "graduationcap",
        cornerRadius: 20
    )
    
    private lazy var professionLabel : UILabel = AppUI.createLabel(
        withText: "Your profession:",
        textColor: .appOrange,
        font: .getMeriendaFont(fontSize: 24),
        alignment: .left
    )
    
    private lazy var professionTextField = AppUI.createTextField(
        withPlaceholder: "",
        placeholderColor: .appPlaceholder,
        bgColor: .appLightYellow,
        font: .getMontserratFont(fontSize: 16),
        textColor: .appBrown,
        leftViewPic: "briefcase",
        cornerRadius: 20
    )
    
    private lazy var hobbiesLabel : UILabel = AppUI.createLabel(
        withText: "Your hobbies:",
        textColor: .appOrange,
        font: .getMeriendaFont(fontSize: 24),
        alignment: .left
    )
    
    private lazy var hobbiesTextField = AppUI.createTextField(
        withPlaceholder: "",
        placeholderColor: .appPlaceholder,
        bgColor: .appLightYellow,
        font: .getMontserratFont(fontSize: 16),
        textColor: .appBrown,
        leftViewPic: "gamecontroller",
        cornerRadius: 20
    )
    
    private lazy var filmLabel : UILabel = AppUI.createLabel(
        withText: "Your favourite films:",
        textColor: .appOrange,
        font: .getMeriendaFont(fontSize: 24),
        alignment: .left
    )
    
    private lazy var filmTextField = AppUI.createTextField(
        withPlaceholder: "",
        placeholderColor: .appPlaceholder,
        bgColor: .appLightYellow,
        font: .getMontserratFont(fontSize: 16),
        textColor: .appBrown,
        leftViewPic: "film",
        cornerRadius: 20
    )
    
    private lazy var giftLabel : UILabel = AppUI.createLabel(
        withText: "Your wish list",
        textColor: .appOrange,
        font: .getMeriendaFont(fontSize: 24),
        alignment: .center
    )
    
    private lazy var giftTextField = AppUI.createTextField(
        withPlaceholder: "",
        placeholderColor: .appPlaceholder,
        bgColor: .appLightYellow,
        font: .getMontserratFont(fontSize: 16),
        textColor: .appBrown,
        leftViewPic: "gift",
        cornerRadius: 20
    )
    
    private lazy var attentionLabel : UILabel = AppUI.createLabel(
        withText: "* Please fill in all fields to register",
        textColor: .appPlaceholder,
        font: .getMontserratFont(fontSize: 18),
        alignment: .left
    )
    
    private lazy var sendButton : UIButton = {
        .config(view: UIButton()) { [weak self] in
            guard let self = self else { return }
            $0.setImage(.regMarine, for: .normal)
            $0.addTarget(self, action: #selector(onSendDataTouched), for: .touchDown)
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
        contentInsetAdjustmentBehavior = .never
        profileImageView.addGestureRecognizer(tapGest)
        
        upContentImageView.addSubviews(personLabel, profileImageView, nameLabel, nameTextField, genderLabel, genderSegmentControl, birthdayLabel, dateView, educationLabel, eduTextField)
        
        downContentImageView.addSubviews(professionLabel, professionTextField, hobbiesLabel, hobbiesTextField, filmLabel, filmTextField, giftLabel, giftTextField, attentionLabel, sendButton)
        
        contentView.addSubviews(upContentImageView, downContentImageView)
        addSubview(contentView)
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: widthAnchor),
            
            upContentImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            upContentImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            upContentImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            upContentImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height),
            
            personLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50),
            personLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 50),
            personLabel.widthAnchor.constraint(equalToConstant: 300),
            
            profileImageView.topAnchor.constraint(equalTo: personLabel.topAnchor),
            profileImageView.centerXAnchor.constraint(equalTo: personLabel.trailingAnchor, constant: -20),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalToConstant: 100),
            
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
            
            educationLabel.topAnchor.constraint(equalTo: dateView.bottomAnchor, constant: 40),
            educationLabel.leadingAnchor.constraint(equalTo: dateView.leadingAnchor, constant: 20),
            
            eduTextField.topAnchor.constraint(equalTo: educationLabel.bottomAnchor, constant: 20),
            eduTextField.leadingAnchor.constraint(equalTo: educationLabel.leadingAnchor, constant: 10),
            eduTextField.widthAnchor.constraint(equalToConstant: 200),
            eduTextField.heightAnchor.constraint(equalToConstant: 50),
            
            downContentImageView.topAnchor.constraint(equalTo: upContentImageView.bottomAnchor),
            downContentImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            downContentImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            downContentImageView.heightAnchor.constraint(equalTo: upContentImageView.heightAnchor),
            downContentImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            professionLabel.topAnchor.constraint(equalTo: downContentImageView.topAnchor),
            professionLabel.leadingAnchor.constraint(equalTo: eduTextField.leadingAnchor, constant: 10),
            
            professionTextField.topAnchor.constraint(equalTo: professionLabel.bottomAnchor, constant: 20),
            professionTextField.leadingAnchor.constraint(equalTo: eduTextField.leadingAnchor),
            professionTextField.widthAnchor.constraint(equalToConstant: 200),
            professionTextField.heightAnchor.constraint(equalToConstant: 50),
            
            hobbiesLabel.topAnchor.constraint(equalTo: professionTextField.bottomAnchor, constant: 40),
            hobbiesLabel.leadingAnchor.constraint(equalTo: professionTextField.leadingAnchor, constant: -30),
            
            hobbiesTextField.topAnchor.constraint(equalTo: hobbiesLabel.bottomAnchor, constant: 20),
            hobbiesTextField.leadingAnchor.constraint(equalTo: hobbiesLabel.leadingAnchor, constant: -30),
            hobbiesTextField.widthAnchor.constraint(equalToConstant: 240),
            hobbiesTextField.heightAnchor.constraint(equalToConstant: 50),
            
            filmLabel.topAnchor.constraint(equalTo: hobbiesTextField.bottomAnchor, constant: 40),
            filmLabel.leadingAnchor.constraint(equalTo: hobbiesTextField.leadingAnchor),
            
            filmTextField.topAnchor.constraint(equalTo: filmLabel.bottomAnchor, constant: 20),
            filmTextField.leadingAnchor.constraint(equalTo: hobbiesTextField.leadingAnchor, constant: -30),
            filmTextField.widthAnchor.constraint(equalToConstant: 240),
            filmTextField.heightAnchor.constraint(equalToConstant: 50),
            
            giftLabel.topAnchor.constraint(equalTo: filmTextField.bottomAnchor, constant: 40),
            giftLabel.leadingAnchor.constraint(equalTo: filmTextField.leadingAnchor, constant: -30),
            giftLabel.widthAnchor.constraint(equalToConstant: 300),
            
            giftTextField.topAnchor.constraint(equalTo: giftLabel.bottomAnchor, constant: 30),
            giftTextField.leadingAnchor.constraint(equalTo: giftLabel.leadingAnchor, constant: -20),
            giftTextField.widthAnchor.constraint(equalToConstant: 250),
            giftTextField.heightAnchor.constraint(equalToConstant: 50),
            
            attentionLabel.topAnchor.constraint(equalTo: giftTextField.bottomAnchor, constant: 30),
            attentionLabel.leadingAnchor.constraint(equalTo: giftTextField.leadingAnchor),
            attentionLabel.widthAnchor.constraint(equalToConstant: 250),
            
            sendButton.topAnchor.constraint(equalTo: downContentImageView.bottomAnchor, constant: -150),
            sendButton.centerXAnchor.constraint(equalTo: downContentImageView.centerXAnchor, constant: -60),
            sendButton.widthAnchor.constraint(equalToConstant: 95),
            sendButton.heightAnchor.constraint(equalToConstant: 90),
        
        ])
    }
    
    @objc private func onProfileImageViewTap() {
        self.chooseProfilePicture?()
    }
    
    @objc private func onSendDataTouched() {
        guard let image = profileImageView.image else { print("no image"); return}
        self.sendData?(image)
    }
}

extension PersonView : PersonViewProtocol {
    
    func getPersonData(completion: (Result<Bool, FieldErrors>) -> Void) {
        
        guard let name = nameTextField.text, name != "",
                let edu = eduTextField.text, edu != "",
                let prof = professionTextField.text, prof != "",
                let hobbies = hobbiesTextField.text, hobbies != "",
                let film = filmTextField.text, film != "",
                let gift = giftTextField.text, gift != ""
        else {
            completion(.failure(FieldErrors.unfilledField))
            return
        }
        
        UserData.name = name
        UserData.education = edu
        UserData.profession = prof
        UserData.hobbies = hobbies
        UserData.film = film
        UserData.gift = gift
        
        let bDay = datePicker.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        UserData.birthday = dateFormatter.string(from: bDay)
        
        UserData.gender = genderSegmentControl.titleForSegment(at: genderSegmentControl.selectedSegmentIndex)!
        
        completion(.success(true))
    }
}

extension PersonView : UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            profileImageView.image = image
            profileImageView.contentMode = .scaleAspectFill
        }
        picker.dismiss(animated: true)
    }
}
