import UIKit

protocol PassViewProtocol : UIImageView {
    
}

final class PassView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        activateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension PassView {
    private func setUpView() {
        image = .backMerged
        isUserInteractionEnabled = true
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            
        ])
    }
}

extension PassView : PassViewProtocol {
    
}
