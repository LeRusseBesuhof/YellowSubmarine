import Foundation
import FirebaseAuth
import FirebaseFirestore

final class RegistrationModel {
    
    func userRegistration(userData: UserRegData, completion: @escaping (Result<Bool, Error>) -> Void) {
        Auth.auth().createUser(withEmail: userData.email, password: userData.password) { [weak self] result, err in
            
            guard let self = self else { return }
            
            guard err == nil else {
                completion(.failure(err!))
                return
            }
            
            if let user = result?.user {
                
                // user.sendEmailVerification()
                
                let userData : [String : Any] = [
                    "name" : userData.name,
                    "isActive" : true
                ]
                
                Firestore.firestore()
                    .collection("users")
                    .document(user.uid)
                    .setData(userData)
                
                completion(.success(true))
            }

        }
    }
    
    func setUserRegData(name: String, email: String, password: String) -> UserRegData {
        UserRegData(name: name, email: email, password: password)
    }
    
}

struct UserRegData {
    let name : String
    let email : String
    let password : String
}
