import Foundation

protocol NoteModelProtocol : AnyObject {
    func getNoteData() -> Note
}

final class NoteModel {
    private var note : Note
    
    init(_ note: Note) {
        self.note = note
    }
}

extension NoteModel : NoteModelProtocol {
    func getNoteData() -> Note { note }
}
