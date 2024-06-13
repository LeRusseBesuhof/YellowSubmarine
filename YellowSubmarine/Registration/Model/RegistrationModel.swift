import Foundation
import FirebaseAuth
import FirebaseFirestore

protocol RegistrationModelProtocol : AnyObject {
    func userRegistration(completion: @escaping (Result<Bool, Error>) -> Void)
    func setUserInitialDatabaseData(name: String, uid: String)
    func setUserRegData(name: String, email: String, password: String)
    func getUserRegData() -> UserRegData
}

final class RegistrationModel {
    
    private var userRegData : UserRegData?
    
}

extension RegistrationModel : RegistrationModelProtocol {
    
    func setUserRegData(name: String, email: String, password: String) {
        userRegData = UserRegData(name: name, email: email, password: password)
    }
    
    func getUserRegData() -> UserRegData {
        guard let someUserRegData = userRegData else { return UserRegData(name: .simpleNickname, email: .simpleEmail, password: .simplePassword) }
        return someUserRegData
    }
    
    
    func userRegistration(completion: @escaping (Result<Bool, Error>) -> Void) {
        
        Auth.auth().createUser(withEmail: userRegData?.email ?? .simpleEmail, password: userRegData?.password ?? .simplePassword) { [weak self] result, err in
            
            guard let self = self else { return }
            
            guard err == nil else {
                completion(.failure(err!))
                return
            }
            
            if let user = result?.user {
                
                // user.sendEmailVerification()
                
                setUserInitialDatabaseData(name: userRegData?.name ?? .simpleNickname, uid: user.uid)
                
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
