import Foundation
import UIKit
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

protocol PersonModelProtocol : AnyObject {
    func uploadPersonalUserData(_ personData: PersonData)
    func uploadImage(imgData: Data)
}

final class PersonModel {
    
    private func getUserID() -> String? {
        guard let uid = Auth.auth().currentUser?.uid else { return nil }
            return uid
    }
    
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
    
    private func addProfileImageLink(urlString: String) {
        guard let uid = getUserID() else { return }
        Firestore.firestore().collection("users").document(uid).setData([
            "profile image": urlString
        ], merge: true)
    }
    
}

extension PersonModel : PersonModelProtocol {
    
    func uploadImage(imgData: Data) {
        
        guard let uid = getUserID() else { return }
        
        let imageName = UUID().uuidString + ".jpeg"
        let ref = Storage.storage().reference().child(uid).child("gallery").child(imageName)
        
        self.uploadOneImage(imgData, ref) { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let url):
                self.addProfileImageLink(urlString: url.absoluteString)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func uploadPersonalUserData(_ personData: PersonData) {
        
        guard let uid = getUserID() else { return }
        
        let dataBase = Firestore.firestore()
        dataBase.collection("users").document(uid).setData([
            "name": personData.name,
            "gender": personData.gender,
            "birthday": personData.birthday,
            "education": personData.education,
            "profession": personData.profession,
            "hobbies": personData.hobbies,
            "film": personData.film,
            "gift": personData.gift
        ], merge: true)
        
    }
}

struct PersonData {
    var name : String
    var gender : String
    var birthday : Date
    var education : String
    var profession : String
    var hobbies : String
    var film : String
    var gift : String
}

enum StorageErrors : String, Error {
    case unknown = "Unknown Error!\nSomething went wrong"
    case noObject = "Object not Found!"
    case unauthentificated = "The user is not authorised!\nPlease log in and try again"
    case anyError = "There's an error"
}

enum FieldErrors : String, Error {
    case unfilledField = "Please fill in all fields!"
}
