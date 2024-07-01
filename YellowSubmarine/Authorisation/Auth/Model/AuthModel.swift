import Foundation
import FirebaseAuth

protocol AuthModelProtocol : AnyObject {
    func signIn(completion: @escaping (Result<Bool, AuthErrors>) -> Void)
    func sendResetEmail(_ email: String, completion: @escaping (Error?) -> Void)
}

final class AuthModel { }

extension AuthModel : AuthModelProtocol {
    
    func signIn(completion: @escaping (Result<Bool, AuthErrors>) -> Void) {
        
        Auth.auth().signIn(withEmail: UserData.email, password: UserData.password) { result, err  in
            
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
                    completion(.failure(.anyError))
                }
                return
            }
            
            if let _ = result?.user.uid {
                completion(.success(true))
            }
        }
    }
    
    func sendResetEmail(_ email: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { err in
            guard err == nil else {
                completion(err)
                return
            }
            completion(nil)
        }
    }
}
