import Foundation
import FirebaseAuth
import FirebaseFirestore

protocol RegisterModelProtocol : AnyObject {
    func userRegistration(userRegData: UserRegData, completion: @escaping (Result<Bool, RegErrors>) -> Void)
    func setUserInitialDatabaseData(nick: String, email: String, uid: String)
}

final class RegisterModel { }

extension RegisterModel : RegisterModelProtocol {
    
    func userRegistration(userRegData: UserRegData, completion: @escaping (Result<Bool, RegErrors>) -> Void) {
        
        Auth.auth().createUser(withEmail: userRegData.email, password: userRegData.password) { [weak self] result, err in
            
            guard let self = self else { return }
            
            guard err == nil else {
                let authError = AuthErrorCode(_nsError: err! as NSError)
                switch authError.code {
                case AuthErrorCode.weakPassword:
                    completion(.failure(.weakPassword))
                case AuthErrorCode.invalidEmail:
                    completion(.failure(.invalidEmail))
                case AuthErrorCode.emailAlreadyInUse:
                    completion(.failure(.emailAlreadyInUse))
                case AuthErrorCode.operationNotAllowed:
                    completion(.failure(.operationNotAllowed))
                default:
                    print(authError.userInfo)
                }
                return
            }
            
            if let user = result?.user {
                
                // user.sendEmailVerification()
                
                setUserInitialDatabaseData(nick: userRegData.name, email: userRegData.email, uid: user.uid)
                
                completion(.success(true))
            }

        }
    }
    
    func setUserInitialDatabaseData(nick: String, email: String, uid: String) {
        let userData : [String : Any] = [
            "nick" : nick,
            "email" : email,
        ]
        
        Firestore.firestore()
            .collection("users")
            .document(uid)
            .setData(userData)
    }
}

struct UserRegData {
    let name : String
    let email : String
    let password : String
}

enum RegErrors : String, Error {
    case weakPassword = "Weak Password!\nPassword length must be at least 8 characters long!"
    case invalidEmail = "Invalid email adress"
    case emailAlreadyInUse = "Email is already in use!\nTry another one"
    case operationNotAllowed = "Sorry!\n This operation is not allowed!"
}
