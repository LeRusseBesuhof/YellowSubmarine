import Foundation
import UIKit

protocol CreationViewProtocol : UIView {
    var createNote : (() -> Void)? { get set }
    
    func getNoteData(completion: (Result<(name: String, text: String), NoteErrors>) -> Void)
}

final class CreationView : UIView {
    
    internal var createNote: (() -> Void)?
    
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
            
            $0.layer.cornerRadius = 30
            $0.backgroundColor = .white
            $0.setTitle("Save changes", for: .normal)
            $0.setTitleColor(.appBrown, for: .normal)
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
        
        addSubviews(noteNameTextField, noteFillTextField)
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            noteNameTextField.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            noteNameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            noteNameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            noteNameTextField.heightAnchor.constraint(equalToConstant: 60),
            
            noteFillTextField.topAnchor.constraint(equalTo: noteNameTextField.bottomAnchor, constant: 30),
            noteFillTextField.leadingAnchor.constraint(equalTo: noteNameTextField.leadingAnchor),
            noteFillTextField.trailingAnchor.constraint(equalTo: noteNameTextField.trailingAnchor),
            noteFillTextField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -200)
        ])
    }
    
    @objc private func onCreateNoteTouch() {
        self.createNote?()
    }
}

extension CreationView : CreationViewProtocol {
    func getNoteData(completion: (Result<(name: String, text: String), NoteErrors>) -> Void) {
        
        guard let name = noteNameTextField.text, name != "", let text = noteNameTextField.text, text != "" else {
            completion(.failure(NoteErrors.empty))
            return
        }
        completion(.success((name: name, text: text)))
    }
}
