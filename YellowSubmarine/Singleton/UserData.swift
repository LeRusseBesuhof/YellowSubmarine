import Foundation

final class UserData {
    
    static let shared = UserData()
    
    private init() { }
    
    static var nick : String = ""
    static var email : String = ""
    static var password : String = ""
    static var image : String = ""
    static var name : String = ""
    static var gender : String = ""
    static var birthday : Date = Date()
    static var education : String = ""
    static var profession : String = ""
    static var hobbies : String = ""
    static var film : String = ""
    static var gift : String = ""
}
