import Foundation
import UIKit
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

protocol PersonModelProtocol : AnyObject {
    func uploadPersonalUserData()
    func uploadImage(imgData: Data)
}

final class PersonModel {
    
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
        guard let uid = UserData.shared.userID else { return }
        
        Firestore.firestore().collection("users").document(uid).setData([
            "imgLink": urlString
        ], merge: true)
    }
    
}

extension PersonModel : PersonModelProtocol {
    
    func uploadImage(imgData: Data) {
        
        guard let uid = UserData.shared.userID else { return }
        
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
    
    func uploadPersonalUserData() {
        
        guard let uid = UserData.shared.userID else { return }
        
        let dataBase = Firestore.firestore()
        dataBase.collection("users").document(uid).setData([
            "name": UserData.name,
            "gender": UserData.gender,
            "birthday": UserData.birthday,
            "education": UserData.education,
            "profession": UserData.profession,
            "hobbies": UserData.hobbies,
            "film": UserData.film,
            "gift": UserData.gift
        ], merge: true)
        
    }
}
