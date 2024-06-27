import Foundation
import FirebaseAuth
import FirebaseFirestore

protocol ProfileModelProtocol : AnyObject {
    func loadUserData(completion: @escaping (Result<Bool, Error>) -> Void)
}

final class ProfileModel {
    
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
}
