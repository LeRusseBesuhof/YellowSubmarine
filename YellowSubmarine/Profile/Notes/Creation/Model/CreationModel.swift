import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

protocol CreationModelProtocol : AnyObject {
    func uploadNote(_ noteData: NoteData) -> String
    func uploadNoteImage(_ imgData: Data, _ noteRef: String)
}

final class CreationModel {
    
    private func uploadOneImage(_ imgData: Data, _ storageLink: FirebaseStorage.StorageReference, completion: @escaping (Result<URL, StorageErrors>) -> Void) {
        
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
    
    private func addNoteImageLink(_ urlString: String, _ noteReference: String) {
        guard let uid = UserData.shared.userID else { return }
        
        Firestore.firestore()
            .collection("users")
            .document(uid)
            .collection("notes")
            .document(noteReference)
            .setData([
            "imgLink": urlString
        ], merge: true)
    }
}

extension CreationModel : CreationModelProtocol {
    
    func uploadNote(_ noteData: NoteData) -> String {
        guard let uid = UserData.shared.userID else { return "" }
        
        let newNoteRef = UUID().uuidString
        
        Firestore.firestore()
            .collection("users")
            .document(uid)
            .collection("notes")
            .document(newNoteRef)
            .setData([
                "name" : noteData.name,
                "date" : noteData.date,
                "text" : noteData.text,
                "firestoreLink" : newNoteRef
            ], merge: true)
        
        return newNoteRef
    }
    
    func uploadNoteImage(_ imgData: Data, _ noteRef: String) {
        
        guard let uid = UserData.shared.userID else { return }
        
        let imageName = noteRef + ".jpeg"
        let ref = Storage.storage().reference().child(uid).child("notes").child(imageName)
        
        self.uploadOneImage(imgData, ref) { result in
            
            switch result {
            case .success(let url):
                self.addNoteImageLink(url.absoluteString, noteRef)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}

struct NoteData : Identifiable {
    var id: String = UUID().uuidString
    let name : String
    let text : String
    let date : String
}
