import Foundation
import FirebaseAuth
import FirebaseFirestore

protocol RegistrationModelProtocol : AnyObject {
    func userRegistration(userRegData: UserRegData, completion: @escaping (Result<Bool, RegErrors>) -> Void)
    func setUserInitialDatabaseData(name: String, uid: String)
}

final class RegistrationModel { }

extension RegistrationModel : RegistrationModelProtocol {
    
    func userRegistration(userRegData: UserRegData, completion: @escaping (Result<Bool, RegErrors>) -> Void) {
        
        Auth.auth().createUser(withEmail: userRegData.email, password: userRegData.password) { result, err in
            
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
            
            if let _ = result?.user {
                
                // user.sendEmailVerification()
                
                // setUserInitialDatabaseData(name: userRegData.name, uid: user.uid)
                
                completion(.success(true))
            }

        }
    }
    
    func setUserInitialDatabaseData(name: String, uid: String) {
        let userData : [String : Any] = [
            "name" : name,
            "isActive" : true
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
