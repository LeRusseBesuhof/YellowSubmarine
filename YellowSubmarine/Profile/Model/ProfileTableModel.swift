import Foundation

struct ProfileTableModel : Identifiable {
    var id: String = UUID().uuidString
    var image : String
    var field: String
    
    static func getMockData() -> [ProfileTableModel] {
        [
            ProfileTableModel(image: "education", field: UserData.education),
            ProfileTableModel(image: "profession", field: UserData.profession),
            ProfileTableModel(image: "hobby", field: UserData.hobbies),
            ProfileTableModel(image: "film", field: UserData.film),
            ProfileTableModel(image: "gift", field: UserData.gift),
        ]
    }
}
