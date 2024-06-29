import UIKit

protocol ProfileViewProtocol : UIImageView {
    var profileImage : UIImageView { get set }
    var chooseProfileImage : (() -> Void)? { get set }
    var imagePicker : UIImagePickerController { get }
    
    func updateData()
}

final class ProfileView: UIImageView {
    
    internal var chooseProfileImage: (() -> Void)?
    
    private lazy var nickLabel : UILabel = AppUI.createLabel(
        withText: "",
        textColor: .white,
        font: .getAmitaFont(fontType: .bold, fontSize: 40),
        alignment: .center)
    
    internal lazy var profileImage : UIImageView = AppUI.createImageView(
        image: .travelBlogger,
        tintColor: .appBrown,
        cornerRadius: 80,
        borderWidth: 6
    )
    
    private lazy var onProfileImageTap = UITapGestureRecognizer(target: self, action: #selector(tapGest))
    
    private lazy var nameLabel : UILabel = AppUI.createLabel(
        withText: "",
        textColor: .black,
        font: .getAmitaFont(fontType: .bold, fontSize: 32),
        alignment: .center
    )
    
    private lazy var birthdayLabel : UILabel = AppUI.createLabel(
        withText: "",
        textColor: .black,
        font: .getMontserratFont(fontSize: 14),
        alignment: .center)
    
    private lazy var genderLabel : UILabel = AppUI.createLabel(
        withText: "",
        textColor: .black,
        font: .getMontserratFont(fontSize: 18),
        alignment: .center)
    
    private lazy var lilStack : UIStackView = { st in
        st.translatesAutoresizingMaskIntoConstraints = false
        st.alignment = .center
        st.axis = .horizontal
        st.distribution = .fill
        birthdayLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        [birthdayLabel, genderLabel].forEach
        { st.addArrangedSubview($0) }
        return st
    }(UIStackView())
    
    private lazy var emailLabel : UILabel = AppUI.createLabel(
        withText: "",
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
    
    private var mockData = ProfileTableModel.getMockData()
    
    private lazy var tableView : UITableView = {
        .config(view: UITableView()) {
            $0.dataSource = self
            $0.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
            $0.bouncesVertically = false
        }
    }()
    
    internal lazy var imagePicker : UIImagePickerController = {
        $0.delegate = self
        $0.allowsEditing = true
        $0.sourceType = .photoLibrary
        return $0
    }(UIImagePickerController())
    
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
        profileImage.isUserInteractionEnabled = true
        profileImage.addGestureRecognizer(onProfileImageTap)
        
        canvasView.addSubviews(profileImage, nameLabel, lilStack, emailLabel, tableView)
        addSubviews(nickLabel, canvasView)
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            nickLabel.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            nickLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            canvasView.topAnchor.constraint(equalTo: nickLabel.bottomAnchor, constant: 90),
            canvasView.leadingAnchor.constraint(equalTo: leadingAnchor),
            canvasView.trailingAnchor.constraint(equalTo: trailingAnchor),
            canvasView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            profileImage.topAnchor.constraint(equalTo: canvasView.topAnchor, constant: -80),
            profileImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            profileImage.widthAnchor.constraint(equalToConstant: 160),
            profileImage.heightAnchor.constraint(equalToConstant: 160),
            
            nameLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 5),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            
            lilStack.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            lilStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            lilStack.widthAnchor.constraint(equalToConstant: 125),
            
            emailLabel.topAnchor.constraint(equalTo: lilStack.bottomAnchor, constant: 10),
            emailLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            emailLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 30),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }
    
    @objc private func tapGest() {
        self.chooseProfileImage?()
    }
}

extension ProfileView : ProfileViewProtocol {
    func updateData() {
        profileImage.contentMode = .scaleAspectFill
        
        nickLabel.text = UserData.nick
        nameLabel.text = UserData.name
        birthdayLabel.text = UserData.birthday
        genderLabel.text = UserData.gender == "male" ? .male : .female
        emailLabel.text = UserData.email
        
        mockData = ProfileTableModel.getMockData()
        tableView.reloadData()
    }
}

extension ProfileView : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mockData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = mockData[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var config = cell.defaultContentConfiguration()
        cell.accessoryType = .none
        cell.selectionStyle = .none
        cell.contentConfiguration = config.setConfig(
            text: item.field,
            font: .getMontserratFont(fontSize: 16),
            image: item.image,
            sndText: item.category,
            sndTextColor: .appSecondaryText,
            sndTextFont: .getMontserratFont(fontSize: 12)
        )
        return cell
    }
}

extension ProfileView : UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            profileImage.image = image
            profileImage.contentMode = .scaleAspectFill
        }
        picker.dismiss(animated: true)
    }
}
