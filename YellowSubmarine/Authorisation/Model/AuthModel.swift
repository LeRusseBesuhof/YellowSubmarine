import Foundation
import FirebaseAuth

final class AuthModel {
    
    func signIn(userData : AuthUserData, completion: @escaping (Result<Bool, AuthErrors>) -> Void) {
        
        Auth.auth().signIn(withEmail: userData.email, password: userData.password) { result, err  in
            
            guard err == nil else {
                let authError = AuthErrorCode(_nsError: err! as NSError)
                switch authError.code {
                case AuthErrorCode.wrongPassword:
                    completion(.failure(.wrongPassword))
                case AuthErrorCode.invalidEmail:
                    completion(.failure(.invalidEmail))
                case AuthErrorCode.unverifiedEmail:
                    completion(.failure(.unverifiedEmail))
                case AuthErrorCode.invalidCredential:
                    completion(.failure(.userNotFound))
                default:
                    print(authError.userInfo)
                }
                return
            }
            
            if let _ = result?.user.uid {
                completion(.success(true))
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

enum AuthErrors : String, Error {
    case wrongPassword = "Wrong Password"
    case invalidEmail = "Invalid email adress"
    case unverifiedEmail = "Unverified email"
    case userNotFound = "The supplied auth credential is malformed or has expired"
}
