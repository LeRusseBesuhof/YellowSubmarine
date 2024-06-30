import Foundation
import FirebaseStorage
import FirebaseFirestore

protocol NoteModelProtocol : AnyObject {
    func getNoteData() -> Note
    func deleteCurrentImage()
    func deleteNote()
    func uploadNewImage(_ imgData: Data)
    func uploadNoteChanges(_ noteData: NoteData)
}

final class NoteModel {
    private var note : Note
    
    init(_ note: Note) {
        self.note = note
    }

    private func uploadNewNoteImage(_ imgData: Data, _ storageLink: FirebaseStorage.StorageReference, completion: @escaping (Result<URL, StorageErrors>) -> Void) {
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        storageLink.putData(imgData, metadata: metadata) { meta, err in
            
            guard err == nil else {
                let storageError = StorageErrorCode(_bridgedNSError: err! as NSError)
                switch storageError {
                case .unknown: completion(.failure(.unknown))
                case .objectNotFound:
                    completion(.failure(.noObject))
                case .unauthenticated:
                    completion(.failure(.unauthentificated))
                default:
                    completion(.failure(.anyError))
                }
                return
            }
            
            storageLink.downloadURL { url, err in
                guard err == nil else {
                    completion(.failure(.anyError))
                    return
                }
                
                guard let url = url else {
                    completion(.failure(.anyError))
                    return
                }
                
                completion(.success(url))
            }
        }
    }
    
    private func updateNoteImageLink(_ urlString: String, _ noteRef: String) {
        
        guard let uid = UserData.shared.userID else {
            print("no uid")
            return
        }
        
        Firestore.firestore()
            .collection("users")
            .document(uid)
            .collection("notes")
            .document(noteRef)
            .updateData([
                "imgLink" : urlString
            ])
    }
}

extension NoteModel : NoteModelProtocol {
    func getNoteData() -> Note { note }
    
    func deleteCurrentImage() {
        guard let uid = UserData.shared.userID else {
            print("no uid")
            return
        }
        
        let urlString = note.imgUrl
        Storage.storage().reference().child(uid).child("notes").child(urlString).delete { err in
            print(err!.localizedDescription)
        }
    }
    
    func deleteNote() {
        guard let uid = UserData.shared.userID else {
            print("no uid")
            return
        }
        
        deleteCurrentImage()
        let noteRef = note.firestoreLink
        
        Firestore.firestore()
            .collection("users")
            .document(uid)
            .collection("notes")
            .document(noteRef)
            .delete()
    }
    
    func uploadNewImage(_ imgData: Data) {
        guard let uid = UserData.shared.userID else {
            print("no uid")
            return
        }
        
        let imgName = UUID().uuidString + ".jpeg"
        let noteRef = note.firestoreLink
        let imgRef = Storage.storage().reference().child(uid).child("notes").child(imgName)
        
        uploadNewNoteImage(imgData, imgRef) { result in
            
            switch result {
            case .success(let url):
                self.updateNoteImageLink(url.absoluteString, noteRef)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func uploadNoteChanges(_ noteData: NoteData) {
        guard let uid = UserData.shared.userID else {
            print("no uid")
            return
        }
        
        let noteRef = note.firestoreLink
        
        Firestore.firestore()
            .collection("users")
            .document(uid)
            .collection("notes")
            .document(noteRef)
            .updateData([
                "name" : noteData.name,
                "text" : noteData.text
            ])
    }
}
