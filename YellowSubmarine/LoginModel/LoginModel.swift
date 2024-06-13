import Foundation
import FirebaseAuth

final class LoginModel {
    
    func isUserLogin() -> Bool {
        Auth.auth().currentUser?.uid == nil ? false : true
    }
    
    func logOut() {
        
        do {
            try Auth.auth().signOut()
            // NotificationCenter.default.post(name: .setRoot, object: RegisterViewController())
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
