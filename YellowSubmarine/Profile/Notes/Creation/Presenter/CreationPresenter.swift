import Foundation
import UIKit

protocol CreationPresenterProtocol : AnyObject {
    func loadView(view: CreationViewProtocol, controller: CreationViewControllerProtocol)
}

final class CreationPresenter {
    private let model : CreationModelProtocol!
    weak var view : CreationViewProtocol?
    weak var controller : CreationViewControllerProtocol?
    
    struct Dependencies {
        let model : CreationModelProtocol
    }
    
    init(dependencies: Dependencies) {
        self.model = dependencies.model
    }
}

private extension CreationPresenter {
    private func onCreateNoteTouched(_ image: UIImage) {
        self.view?.getNoteData(completion: { result in
            switch result {
            case .success(let data):
                let curNoteData = NoteData(name: data.name, text: data.text, date: data.date)
                let noteRef = model.uploadNote(curNoteData)
                if let imgData = image.jpegData(compressionQuality: 0.1) {
                    model.uploadNoteImage(imgData, noteRef)
                    print(2)
                } else { print("compression went wrong") }
                
                self.controller?.createAlert(message: "Note was successfully uploaded", buttonText: "OK", isClosingAction: true)
            case .failure(let err):
                self.controller?.createAlert(message: err.rawValue, buttonText: "Cancel", isClosingAction: false)
            }
        })
    }
    
    private func onChooseNoteImageTouched() {
        guard let view = self.view else { print("no view"); return }
        self.controller?.presentPickerController(view.imagePicker)
    }
    
    private func setUpHandlers() {
        
        self.view?.createNote = { [weak self] image in
            guard let self = self else { return }
            
            onCreateNoteTouched(image)
        }
        
        self.view?.chooseNoteImage = { [weak self] in
            guard let self = self else { return }
            
            onChooseNoteImageTouched()
        }
    }
}

extension CreationPresenter : CreationPresenterProtocol {
    func loadView(view: CreationViewProtocol, controller: CreationViewControllerProtocol) {
        self.view = view
        self.controller = controller
        
        self.setUpHandlers()
    }
}
