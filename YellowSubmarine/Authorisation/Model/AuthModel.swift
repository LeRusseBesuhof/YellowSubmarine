import Foundation
import FirebaseAuth
import Firebase

final class AuthModel {
    
    func signIn(userData : AuthUserData, completion: @escaping (Result<UserEmailVerification, Error>) -> Void) {
        
        Auth.auth().signIn(withEmail: userData.email, password: userData.password) { result, err  in
            
            guard err == nil else {
                completion(.failure(err!))
                return
            }
            
            if let isVerified = result?.user.isEmailVerified, isVerified {
                completion(.success(.allowed))
            } else {
                completion(.success(.denied))
            }
        }
    }
    
    func setUserAuthData(email: String, password: String) -> AuthUserData {
        AuthUserData(email: email, password: password)
    }
    
}



struct AuthUserData {
    let email: String
    let password: String
}

enum UserEmailVerification {
    case allowed
    case denied
}
