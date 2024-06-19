import Foundation
import FirebaseAuth
import FirebaseFirestore

protocol ProfileModelProtocol : AnyObject {
    func loadUserData(completion: @escaping (Result<ProfileFields, Error>) -> Void)
}

final class ProfileModel {
    
    private func getUserID() -> String? {
        guard let uid = Auth.auth().currentUser?.uid else { return nil }
            return uid
    }
    
}

extension ProfileModel : ProfileModelProtocol {
    
    // TODO: Make using completion handler!
    
    func loadUserData(completion: @escaping (Result<ProfileFields, Error>) -> Void) {
        var profileFields = ProfileFields()
        
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
            profileFields.nick = documents["nick"] as? String ?? ""
            profileFields.email = documents["email"] as? String ?? ""
            profileFields.image = documents["profile image"] as? String ?? ""
            profileFields.name = documents["name"] as? String ?? ""
            profileFields.bDay = documents["birthday"] as? Date ?? Date()
            profileFields.gender = documents["gender"] as? String ?? ""
            
            completion(.success(profileFields))
        }
    }
}

struct ProfileFields {
    var nick : String = ""
    var email : String = ""
    var image : String = ""
    var name : String = ""
    var bDay : Date = Date()
    var gender : String = ""
}

enum DownloadError : String, Error {
    case noUID = "Can't find UID"
    case snapError = "Something wrong with SnapShot"
}
