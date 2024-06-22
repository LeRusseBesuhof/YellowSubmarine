import Foundation
import FirebaseAuth
import FirebaseFirestore

protocol SettingsModelProtocol {
    func updateData(_ dictOfChanges: [String: String])
}

final class SettingsModel {
    private func getUserID() -> String? {
        guard let uid = Auth.auth().currentUser?.uid else { return nil }
            return uid
    }
}

extension SettingsModel : SettingsModelProtocol {
    func updateData(_ dictOfChanges: [String: String]) {
        guard let uid = getUserID() else { return }
        
        let dataBase = Firestore.firestore()
        
        for key in dictOfChanges.keys {
            switch key {
            case .nick:
                // UserData.nick = dictOfChanges[key]!
                dataBase.collection("users").document(uid).updateData(
                    ["nick": dictOfChanges[key]!]
                )
            case .edu:
                // UserData.education = dictOfChanges[key]!
                dataBase.collection("users").document(uid).updateData(
                    ["education": dictOfChanges[key]!]
                )
            case .prof:
                // UserData.profession = dictOfChanges[key]!
                dataBase.collection("users").document(uid).updateData(
                    ["profession": dictOfChanges[key]!]
                )
            case .hobbies:
                // UserData.hobbies = dictOfChanges[key]!
                dataBase.collection("users").document(uid).updateData(
                    ["hobbies": dictOfChanges[key]!]
                )
            case .films:
                // UserData.film = dictOfChanges[key]!
                dataBase.collection("users").document(uid).updateData(
                    ["film": dictOfChanges[key]!]
                )
            case .gift:
                // UserData.gift = dictOfChanges[key]!
                dataBase.collection("users").document(uid).updateData(
                    ["gift": dictOfChanges[key]!]
                )
            default: break
            }
        }
    }
}
