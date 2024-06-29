import Foundation
import SDWebImage

protocol ProfilePresenterProtocol : AnyObject {
    func loadView(controller: ProfileViewControllerProtocol, view: ProfileViewProtocol)
    func updateData()
}

final class ProfilePresenter {
    let model : ProfileModelProtocol!
    let router : Router!
    weak var view : ProfileViewProtocol?
    weak var controller : ProfileViewControllerProtocol?
    
    struct Dependencies {
        let model : ProfileModelProtocol
        let router : Router
    }
    
    init(dependencies: Dependencies) {
        self.model = dependencies.model
        self.router = dependencies.router
    }
}

private extension ProfilePresenter {
    
    private func onChooseProfileImageTouched() {
        guard let view = self.view else { print("no view"); return }
        self.controller?.presentPickerController(view.imagePicker)
        
        loadProfileImage()
    }
    
    private func loadProfileImage() {
        self.model.loadProfileImage { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let success):
                if success {
                    view?.profileImage.sd_setImage(with: UserData.image)
                    view?.updateData()
                }
            case .failure(let err):
                controller?.createAlert(message: err.localizedDescription, buttonText: "Cancel", isClosingAction: false)
            }
        }
    }
    
    private func setHandlers() {
        self.model.loadUserData { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let success):
                if success {
                    view?.profileImage.sd_setImage(with: UserData.image)
                    view?.updateData()
                }
            case .failure(let err):
                controller?.createAlert(message: err.localizedDescription, buttonText: "Cancel", isClosingAction: false)
            }
        }
        
        self.view?.chooseProfileImage = { [weak self] in
            guard let self = self else { return }
            self.onChooseProfileImageTouched()
        }
    }
    
}

extension ProfilePresenter : ProfilePresenterProtocol {
    func loadView(controller: ProfileViewControllerProtocol, view: ProfileViewProtocol) {
        self.controller = controller
        self.view = view
        
        self.setHandlers()
    }
    
    func updateData() {
        self.setHandlers()
    }
}
