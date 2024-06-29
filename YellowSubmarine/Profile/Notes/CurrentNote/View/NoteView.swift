import UIKit

protocol NoteViewProtocol : UIImageView {
    var noteData : Note { get set }
}

final class NoteView: UIImageView {
    
    internal var noteData: Note?
    
    private lazy var canvasView : UIView = {
        .config(view: UIView()) {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 50
            $0.clipsToBounds = true
        }
    }()
    
    private lazy var noteImageView : UIImageView = AppUI.createImageView(
        image: <#T##UIImage#>,
        tintColor: <#T##UIColor#>,
        cornerRadius: <#T##CGFloat#>)
    
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
        
        addSubviews(canvasView)
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            canvasView.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            canvasView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            canvasView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            canvasView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -200),
        ])
    }
}

extension NoteView : NoteViewProtocol {
    
}
