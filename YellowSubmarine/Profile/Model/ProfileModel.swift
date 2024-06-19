import Foundation
import FirebaseAuth
import FirebaseFirestore

protocol ProfileModelProtocol : AnyObject {
    func loadUserData() -> ProfileFields
}

final class ProfileModel {
    
    private func getUserID() -> String? {
        guard let uid = Auth.auth().currentUser?.uid else { return nil }
            return uid
    }
    
}

extension ProfileModel : ProfileModelProtocol {
    
    // TODO: Make using completion handler!
    
    func loadUserData() -> ProfileFields {
        var profileFields = ProfileFields()
        
        guard let uid = getUserID() else {
            print("no uid")
            return profileFields
        }
        
        Firestore.firestore().collection("users").document(uid).getDocument { snap, err in
            guard err == nil else { print("snap went wrong"); return }
            
            if let documents = snap {
                profileFields.nick = documents["nick"] as! String
                profileFields.email = documents["email"] as! String
                profileFields.image = documents["profile image"] as! String
                profileFields.name = documents["name"] as! String
                profileFields.bDay = documents["birthday"] as! Date
                profileFields.gender = documents["gender"] as! String
            }
        }
        
        return profileFields
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
