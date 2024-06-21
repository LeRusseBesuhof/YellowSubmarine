import Foundation
import UIKit

protocol SettingsViewProtocol : UIImageView {
    
}

final class SettingsView : UIImageView {
    
    private lazy var canvasView : UIView = {
        .config(view: UIView()) {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 50
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
        
        addSubviews(canvasView)
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            canvasView.topAnchor.constraint(equalTo: topAnchor, constant: 150),
            canvasView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            canvasView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            canvasView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -150)
        ])
    }
}

extension SettingsView : SettingsViewProtocol {
    
}
