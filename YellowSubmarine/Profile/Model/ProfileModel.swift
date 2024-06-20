import Foundation
import FirebaseAuth
import FirebaseFirestore

protocol ProfileModelProtocol : AnyObject {
    func loadUserData(completion: @escaping (Result<Bool, Error>) -> Void)
}

final class ProfileModel {
    
    private func getUserID() -> String? {
        guard let uid = Auth.auth().currentUser?.uid else { return nil }
            return uid
    }
    
}

extension ProfileModel : ProfileModelProtocol {
    
    func loadUserData(completion: @escaping (Result<Bool, Error>) -> Void) {
       
        guard let uid = getUserID() else {
            completion(.failure(DownloadError.noUID))
            print("no uid")
            return
        }
        
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
            UserData.image = documents["profile image"] as? String ?? ""
            UserData.name = documents["name"] as? String ?? ""
            UserData.birthday = documents["birthday"] as? String ?? ""
            UserData.gender = documents["gender"] as? String ?? ""
            UserData.education = documents["education"] as? String ?? ""
            UserData.profession = documents["profession"] as? String ?? ""
            UserData.hobbies = documents["hobbies"] as? String ?? ""
            UserData.film = documents["film"] as? String ?? ""
            UserData.gift = documents["gift"] as? String ?? ""
            
            completion(.success(true))
        }
    }
}

enum DownloadError : String, Error {
    case noUID = "Can't find UID"
    case snapError = "Something wrong with SnapShot"
}
