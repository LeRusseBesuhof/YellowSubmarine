import Foundation
import FirebaseAuth
import FirebaseFirestore

protocol CreationModelProtocol : AnyObject {
    func uploadNote(_ noteData: NoteData)
}

final class CreationModel {
    private func getUserID() -> String? {
        guard let uid = Auth.auth().currentUser?.uid else { return nil }
            return uid
    }
}

extension CreationModel : CreationModelProtocol {
    func uploadNote(_ noteData: NoteData) {
        guard let uid = getUserID() else { return }
        
        
    }
}

struct NoteData : Identifiable {
    var id: String = UUID().uuidString
    let name : String
    let text : String
}

enum NoteErrors : String, Error {
    case empty = "Note is empty!\nPlease write something"
}
