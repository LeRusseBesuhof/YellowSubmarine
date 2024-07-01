import Foundation
import UIKit
import FirebaseFirestore
import FirebaseStorage

protocol NotePresenterProtocol : AnyObject {
    func loadView(view: NoteViewProtocol, controller: NoteViewControllerProtocol)
}

final class NotePresenter {
    
    private var model : NoteModelProtocol!
    private weak var view : NoteViewProtocol?
    private weak var controller : NoteViewControllerProtocol?
    
    struct Dependencies {
        let model : NoteModelProtocol
    }
    
    init(dependencies: Dependencies) {
        self.model = dependencies.model
    }
}

private extension NotePresenter {
    
    private func onChangeImageTouched(_ image: UIImage) {
        guard let view = self.view else { print("no view"); return }
        self.controller?.presentPicker(view.imagePicker)
    }
    
    private func onSaveChangesTouched() {
        self.model.deleteCurrentImage()
        guard let view = self.view else { print("no view"); return }
        
        let image = view.noteImageView.image!
        guard let imgData = image.jpegData(compressionQuality: 0.1) else {
            print("compression error")
            return
        }
        
        self.model.uploadNewImage(imgData)
        
        let noteData = view.getChangedData()
        self.model.uploadNoteChanges(noteData)
        self.controller?.createAlert(message: "Changes were successfully saved", buttonText: "OK", isClosingAction: true)
    }
    
    private func onDeleteNoteTouched() {
        self.model.deleteNote()
        self.controller?.createAlert(message: "Note was successfully deleted", buttonText: "OK", isClosingAction: true)
    }
    
    private func setUpNoteData() {
        let noteData = self.model.getNoteData()
        
        guard let urlString = URL(string: noteData.imgUrl) else {
            print("not url")
            return
        }
        self.view?.noteImageView.sd_setImage(with: urlString)
        self.view?.updateView(noteData.name, noteData.date, noteData.text)
    }
    
    private func setUpHandlers() {
        setUpNoteData()
        
        self.view?.changeImage = { [weak self] image in
            guard let self = self else { return }
            
            onChangeImageTouched(image)
        }
        
        self.view?.deleteNote = { [weak self] in
            guard let self = self else { return }
            
            onDeleteNoteTouched()
        }
        
        self.view?.changeNote = { [weak self] in
            guard let self = self else { return }
            
            onSaveChangesTouched()
        }
    }
}

extension NotePresenter : NotePresenterProtocol {
    func loadView(view: NoteViewProtocol, controller: any NoteViewControllerProtocol) {
        self.view = view
        self.controller = controller
        
        self.setUpHandlers()
    }
}
