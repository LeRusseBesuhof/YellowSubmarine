import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

protocol ProfileModelProtocol : AnyObject {
    func loadUserData(completion: @escaping (Result<Bool, Error>) -> Void)
    func loadProfileImage(completion: @escaping (Result<Bool, Error>) -> Void)
}

final class ProfileModel {
    
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
        ])
    }
}

extension ProfileModel : ProfileModelProtocol {
    
    func loadUserData(completion: @escaping (Result<Bool, Error>) -> Void) {
       
        guard let uid = UserData.shared.userID else { return }
        
        Firestore.firestore().collection("users").document(uid).getDocument { snap, err in
            guard err == nil else {
                completion(.failure(err!))
                return
            }
            
            guard let documents = snap else {
                completion(.failure(DownloadError.snapError))
                return
            }
            
            UserData.nick = documents["nick"] as? String ?? ""
            UserData.email = documents["email"] as? String ?? ""
            UserData.name = documents["name"] as? String ?? ""
            UserData.birthday = documents["birthday"] as? String ?? ""
            UserData.gender = documents["gender"] as? String ?? ""
            UserData.education = documents["education"] as? String ?? ""
            UserData.profession = documents["profession"] as? String ?? ""
            UserData.hobbies = documents["hobbies"] as? String ?? ""
            UserData.film = documents["film"] as? String ?? ""
            UserData.gift = documents["gift"] as? String ?? ""
            
            if let urlString = documents["imgLink"] as? String, let url = URL(string: urlString) {
                UserData.image = url
            }
            completion(.success(true))
        }
    }
    
    func uploadProfileImage(_ imgData: Data) {
        
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
    
    func loadProfileImage(completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let uid = UserData.shared.userID else { return }
        
        Firestore.firestore().collection("users").document(uid).getDocument { snap, err in
            guard err == nil else {
                completion(.failure(err!))
                return
            }
            
            guard let documents = snap else {
                completion(.failure(DownloadError.snapError))
                return
            }
            
            if let urlString = documents["imgLink"] as? String, let url = URL(string: urlString) {
                UserData.image = url
            }
            completion(.success(true))
        }
    }
}
