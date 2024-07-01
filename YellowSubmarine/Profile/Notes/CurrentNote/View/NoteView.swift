import UIKit

protocol NoteViewProtocol : UIImageView {
    var noteImageView : UIImageView { get set }
    var imagePicker : UIImagePickerController { get set }
    var changeImage : ((UIImage) -> Void)? { get set }
    var changeNote : (() -> Void)? { get set }
    var deleteNote : (() -> Void)? { get set }
    
    func updateView(_ name: String, _ date: String, _ text: String)
    func getChangedData() -> NoteData
}

final class NoteView: UIImageView {
    
    private lazy var canvasView : UIView = {
        .config(view: UIView()) {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 50
            $0.clipsToBounds = true
        }
    }()
    
    internal var changeImage : ((UIImage) -> Void)?
    
    internal lazy var noteImageView : UIImageView = AppUI.createImageView(
        image: UIImage(systemName: "camera")!,
        tintColor: .appOrange,
        cornerRadius: 30,
        borderWidth: 0
    )
    
    private lazy var onImageTapGest = UITapGestureRecognizer(target: self, action: #selector(onChangeImageTouch))
    
    internal lazy var imagePicker : UIImagePickerController = {
        $0.delegate = self
        $0.sourceType = .photoLibrary
        $0.allowsEditing = true
        return $0
    }(UIImagePickerController())
    
    private lazy var noteName : UITextField = AppUI.createTextField(
        withPlaceholder: "",
        placeholderColor: .black,
        bgColor: .white,
        font: .getMontserratFont(fontSize: 28),
        textColor: .black,
        leftViewPic: "",
        cornerRadius: 0
    )
    
    private lazy var noteDate : UILabel = AppUI.createLabel(
        withText: "",
        textColor: .appPlaceholder,
        font: .getMontserratFont(fontSize: 14),
        alignment: .center
    )
    
    private lazy var noteText : UITextView = {
        .config(view: UITextView()) {
            $0.font = .getMontserratFont(fontSize: 16)
            $0.textColor = .black
            $0.isEditable = true
            $0.textAlignment = .left
            $0.isScrollEnabled = true
        }
    }()
    
    internal var changeNote: (() -> Void)?
    
    private lazy var saveButton : UIButton = AppUI.createButton(
        text: "Save changes",
        textColor: .appLightBrown,
        font: .getMontserratFont(fontSize: 24),
        cornerRadius: 20
    )
    
    internal var deleteNote : (() -> Void)?
    
    private lazy var deleteButton : UIButton = AppUI.createButton(
        text: "Delete note",
        textColor: .red,
        font: .getMontserratFont(fontSize: 24),
        cornerRadius: 20
    )
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        activateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension NoteView {
    private func setUpView() {
        image = .backMerged
        isUserInteractionEnabled = true
        noteImageView.addGestureRecognizer(onImageTapGest)
        noteName.textAlignment = .center
        saveButton.addTarget(self, action: #selector(onChangeNoteTouch), for: .touchDown)
        deleteButton.addTarget(self, action: #selector(onDeleteNoteTouch), for: .touchDown)
        
        canvasView.addSubviews(noteImageView, noteName, noteDate, noteText)
        addSubviews(canvasView, saveButton, deleteButton)
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            canvasView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            canvasView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            canvasView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            canvasView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -220),
            
            noteImageView.topAnchor.constraint(equalTo: canvasView.topAnchor, constant: 20),
            noteImageView.leadingAnchor.constraint(equalTo: canvasView.leadingAnchor, constant: 20),
            noteImageView.trailingAnchor.constraint(equalTo: canvasView.trailingAnchor, constant: -20),
            noteImageView.heightAnchor.constraint(equalToConstant: 200),
            
            noteName.topAnchor.constraint(equalTo: noteImageView.bottomAnchor, constant: 15),
            noteName.leadingAnchor.constraint(equalTo: noteImageView.leadingAnchor),
            noteName.trailingAnchor.constraint(equalTo: noteImageView.trailingAnchor),
            
            noteDate.topAnchor.constraint(equalTo: noteName.bottomAnchor, constant: 10),
            noteDate.leadingAnchor.constraint(equalTo: noteName.leadingAnchor),
            noteDate.trailingAnchor.constraint(equalTo: noteName.trailingAnchor),
            
            noteText.topAnchor.constraint(equalTo: noteDate.bottomAnchor, constant: 5),
            noteText.leadingAnchor.constraint(equalTo: noteDate.leadingAnchor),
            noteText.trailingAnchor.constraint(equalTo: noteDate.trailingAnchor),
            noteText.bottomAnchor.constraint(equalTo: canvasView.bottomAnchor, constant: -10),
            
            saveButton.topAnchor.constraint(equalTo: canvasView.bottomAnchor, constant: 10),
            saveButton.leadingAnchor.constraint(equalTo: canvasView.leadingAnchor),
            saveButton.trailingAnchor.constraint(equalTo: canvasView.trailingAnchor),
            saveButton.heightAnchor.constraint(equalToConstant: 50),
            
            deleteButton.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 10),
            deleteButton.leadingAnchor.constraint(equalTo: canvasView.leadingAnchor),
            deleteButton.trailingAnchor.constraint(equalTo: canvasView.trailingAnchor),
            deleteButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    @objc private func onChangeImageTouch() {
        self.changeImage?(noteImageView.image!)
    }
    
    @objc private func onChangeNoteTouch() {
        self.changeNote?()
    }
    
    @objc private func onDeleteNoteTouch() {
        self.deleteNote?()
    }
}

extension NoteView : NoteViewProtocol {
    func updateView(_ name: String, _ date: String, _ text: String) {
        noteImageView.contentMode = .scaleAspectFill
        noteName.text = name
        noteDate.text = date
        noteText.text = text
    }
    
    func getChangedData() -> NoteData {
        NoteData(name: noteName.text ?? "", text: noteText.text ?? "", date: "")
    }
}

extension NoteView : UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            noteImageView.image = image
            noteImageView.contentMode = .scaleAspectFill
        }
        picker.dismiss(animated: true)
        
    }
}
