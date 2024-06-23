import Foundation
import FirebaseAuth

final class LoginModel {
    
    func isUserLogin() -> Bool {
        Auth.auth().currentUser?.uid == nil ? false : true
    }
    
    func logOut() {
        
        do {
            try Auth.auth().signOut()
            let rootController = RegisterAssembly.build()
             NotificationCenter.default.post(name: .setRoot, object: rootController)
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
