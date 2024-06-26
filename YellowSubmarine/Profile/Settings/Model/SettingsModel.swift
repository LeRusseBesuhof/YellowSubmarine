import Foundation
import FirebaseAuth
import FirebaseFirestore

protocol SettingsModelProtocol {
    func updateData(_ dictOfChanges: [String: String])
}

final class SettingsModel {
}

extension SettingsModel : SettingsModelProtocol {
    func updateData(_ dictOfChanges: [String: String]) {
        guard let uid = UserData.shared.userID else { return }
        
        let dataBase = Firestore.firestore()
        
        for key in dictOfChanges.keys {
            switch key {
            case .nick:
                dataBase.collection("users").document(uid).updateData(
                    ["nick": dictOfChanges[key]!]
                )
            case .edu:
                dataBase.collection("users").document(uid).updateData(
                    ["education": dictOfChanges[key]!]
                )
            case .prof:
                dataBase.collection("users").document(uid).updateData(
                    ["profession": dictOfChanges[key]!]
                )
            case .hobbies:
                dataBase.collection("users").document(uid).updateData(
                    ["hobbies": dictOfChanges[key]!]
                )
            case .films:
                dataBase.collection("users").document(uid).updateData(
                    ["film": dictOfChanges[key]!]
                )
            case .gift:
                dataBase.collection("users").document(uid).updateData(
                    ["gift": dictOfChanges[key]!]
                )
            default: break
            }
        }
    }
}
