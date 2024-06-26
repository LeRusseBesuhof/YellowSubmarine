import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

protocol CreationModelProtocol : AnyObject {
    func uploadNote(_ noteData: NoteData) -> String
    func uploadNoteImage(imgData: Data, noteReference: String)
}

final class CreationModel {
    
    private func uploadOneImage(_ img: Data?, _ storageLink: FirebaseStorage.StorageReference, completion: @escaping ((Result<URL, StorageErrors>) -> Void)) {
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        guard let data = img else { return }
        
        storageLink.putData(data, metadata: metadata) { meta, err in
            
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
                    print(err!.localizedDescription)
                    completion(.failure(.anyError))
                    return
                }
                
                guard let url = url else {
                    print(err!.localizedDescription)
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
    
    func uploadNoteImage(imgData: Data, noteReference: String) {
        
        guard let uid = UserData.shared.userID else { return }
        
        let imageName = noteReference + ".jpeg"
        let ref = Storage.storage().reference().child(uid).child("notes").child(imageName)
        
        self.uploadOneImage(imgData, ref) { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let url):
                self.addNoteImageLink(url.absoluteString, noteReference)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func uploadNote(_ noteData: NoteData) -> String {
        guard let uid = UserData.shared.userID else { return "" }
        
        Firestore.firestore()
            .collection("users")
            .document(uid)
            .collection("notes")
            .addDocument(data: [
                "name" : noteData.name,
                "date" : noteData.date,
                "text" : noteData.text
            ])
        
        let docRef = Firestore.firestore()
            .collection("users")
            .document(uid)
            .collection("notes")
            .document()
        
        return docRef.documentID
    }
}

struct NoteData : Identifiable {
    var id: String = UUID().uuidString
    let name : String
    let text : String
    let date : String
}
