import Foundation
import UIKit

protocol CreationPresenterProtocol : AnyObject {
    func loadView(view: CreationViewProtocol, controller: CreationViewControllerProtocol)
}

final class CreationPresenter {
    private let creationModel : CreationModelProtocol!
    weak var creationView : CreationViewProtocol?
    weak var creationController : CreationViewControllerProtocol?
    
    struct Dependencies {
        let model : CreationModelProtocol
    }
    
    init(dependencies: Dependencies) {
        self.creationModel = dependencies.model
    }
}

private extension CreationPresenter {
    private func onCreateNoteTouched(_ image: UIImage) {
        creationView?.getNoteData(completion: { result in
            switch result {
            case .success(let data):
                let curNoteData = NoteData(name: data.name, text: data.text, date: data.date)
                let noteRef = creationModel.uploadNote(curNoteData)
                if let imgData = image.jpegData(compressionQuality: 0.1) {
                    creationModel.uploadNoteImage(imgData, noteRef)
                } else { print("compression went wrong") }
                
                creationController?.createAlert(message: "Note was successfully uploaded", buttonText: "OK", isClosingAction: true)
            case .failure(let err):
                creationController?.createAlert(message: err.rawValue, buttonText: "Cancel", isClosingAction: false)
            }
        })
    }
    
    private func onChooseNoteImageTouched() {
        guard let view = self.creationView else { print("no view"); return }
        self.creationController?.presentPickerController(view.imagePicker)
    }
    
    private func setUpHandlers() {
        self.creationView?.createNote = { [weak self] image in
            guard let self = self else { return }
            onCreateNoteTouched(image)
        }
        
        self.creationView?.chooseNoteImage = { [weak self] in
            guard let self = self else { return }
            onChooseNoteImageTouched()
        }
    }
}

extension CreationPresenter : CreationPresenterProtocol {
    func loadView(view: CreationViewProtocol, controller: CreationViewControllerProtocol) {
        self.creationView = view
        self.creationController = controller
        
        self.setUpHandlers()
    }
}
