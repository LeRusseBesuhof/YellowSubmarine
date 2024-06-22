import Foundation

struct ProfileTableModel : Identifiable {
    var id: String = UUID().uuidString
    var image : String
    var field: String
    var category : String
    
    static func getMockData() -> [ProfileTableModel] {
        [
            ProfileTableModel(image: "education", field: UserData.education, category: "Education"),
            ProfileTableModel(image: "profession", field: UserData.profession, category: "Profession"),
            ProfileTableModel(image: "hobby", field: UserData.hobbies, category: "Hobbies"),
            ProfileTableModel(image: "film", field: UserData.film, category: "Favourite films"),
            ProfileTableModel(image: "gift", field: UserData.gift, category: "My wish list"),
        ]
    }
}
