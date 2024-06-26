import Foundation
import UIKit

protocol CreationViewProtocol : UIView {
    var createNote : ((UIImage) -> Void)? { get set }
    var chooseNoteImage : (() -> Void)? { get set }
    var imagePicker : UIImagePickerController { get set }
    
    func getNoteData(completion: (Result<(name: String, text: String, date: String), NoteErrors>) -> Void)
}

final class CreationView : UIView {
    
    internal var createNote: ((UIImage) -> Void)?
    
    internal var chooseNoteImage: (() -> Void)?
    
    internal lazy var imagePicker : UIImagePickerController = {
        $0.delegate = self
        $0.sourceType = .photoLibrary
        $0.allowsEditing = true
        return $0
    }(UIImagePickerController())
    
    private lazy var noteImageView : UIImageView = AppUI.createImageView(
        image: UIImage(systemName: "camera")!,
        tintColor: .appOrange,
        cornerRadius: 20,
        borderWidth: 2
    )
    
    private lazy var onImageTapGest = UITapGestureRecognizer(target: self, action: #selector(onChooseNoteImageTouch))
    
    private lazy var noteNameTextField : UITextField = AppUI.createTextField(
        withPlaceholder: "Note name",
        placeholderColor: .appPlaceholder,
        bgColor: .appLightYellow,
        font: .getMontserratFont(fontSize: 20),
        textColor: .black,
        leftViewPic: "text.cursor",
        cornerRadius: 20
    )
    
    private lazy var noteFillTextField : UITextField = AppUI.createTextField(
        withPlaceholder: "Write there",
        placeholderColor: .appPlaceholder,
        bgColor: .appLightYellow,
        font: .getMontserratFont(fontSize: 20),
        textColor: .black,
        leftViewPic: "pencil.and.list.clipboard",
        cornerRadius: 20
    )
    
    private lazy var createNoteButton : UIButton = {
        .config(view: UIButton()) { [weak self] in
            guard let self = self else { return }
            
            $0.layer.cornerRadius = 20
            $0.layer.borderColor = UIColor.appOrange.cgColor
            $0.layer.borderWidth = 2
            $0.backgroundColor = .white
            $0.setTitle("Save changes", for: .normal)
            $0.setTitleColor(.appOrange, for: .normal)
            $0.titleLabel?.font = .getMontserratFont(fontSize: 24)
            $0.addTarget(self, action: #selector(onCreateNoteTouch), for: .touchDown)
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

private extension CreationView {
    private func setUpView() {
        backgroundColor = .white
        noteImageView.addGestureRecognizer(onImageTapGest)
        
        addSubviews(noteImageView, noteNameTextField, noteFillTextField, createNoteButton)
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            noteImageView.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            noteImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            noteImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            noteImageView.heightAnchor.constraint(equalToConstant: 150),
            
            noteNameTextField.topAnchor.constraint(equalTo: noteImageView.bottomAnchor, constant: 30),
            noteNameTextField.leadingAnchor.constraint(equalTo: noteImageView.leadingAnchor),
            noteNameTextField.trailingAnchor.constraint(equalTo: noteImageView.trailingAnchor),
            noteNameTextField.heightAnchor.constraint(equalToConstant: 60),
            
            noteFillTextField.topAnchor.constraint(equalTo: noteNameTextField.bottomAnchor, constant: 30),
            noteFillTextField.leadingAnchor.constraint(equalTo: noteNameTextField.leadingAnchor),
            noteFillTextField.trailingAnchor.constraint(equalTo: noteNameTextField.trailingAnchor),
            noteFillTextField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -200),
            
            createNoteButton.topAnchor.constraint(equalTo: noteFillTextField.bottomAnchor, constant: 30),
            createNoteButton.leadingAnchor.constraint(equalTo: noteFillTextField.leadingAnchor),
            createNoteButton.trailingAnchor.constraint(equalTo: noteFillTextField.trailingAnchor),
            createNoteButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func onChooseNoteImageTouch() {
        self.chooseNoteImage?()
    }
    
    @objc private func onCreateNoteTouch() {
        guard let image = noteImageView.image else { print("no image"); return}
        self.createNote?(image)
    }
}

extension CreationView : CreationViewProtocol {
    func getNoteData(completion: (Result<(name: String, text: String, date: String), NoteErrors>) -> Void) {
        
        guard let name = noteNameTextField.text, name != "", let text = noteFillTextField.text, text != "" else {
            completion(.failure(NoteErrors.empty))
            return
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let date = dateFormatter.string(from: Date.now)
        
        completion(.success((name: name, text: text, date: date)))
    }
}

extension CreationView : UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            noteImageView.image = image
            noteImageView.contentMode = .scaleAspectFill
        }
        picker.dismiss(animated: true)
    }
}
