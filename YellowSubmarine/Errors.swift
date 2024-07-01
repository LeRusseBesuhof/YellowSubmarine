import Foundation

enum RegErrors : String, Error {
    case weakPassword = "Weak Password!\nPassword length must be at least 8 characters long!"
    case invalidEmail = "Invalid email adress"
    case emailAlreadyInUse = "Email is already in use!\nTry another one"
    case operationNotAllowed = "Sorry!\n This operation is not allowed!"
}

enum AuthErrors : String, Error {
    case wrongPassword = "Wrong Password"
    case invalidEmail = "Invalid email adress"
    case unverifiedEmail = "Unverified email"
    case userNotFound = "The supplied auth credential is malformed or has expired"
    case anyError = "There's an error"
}

enum StorageErrors : String, Error {
    case unknown = "Unknown Error!\nSomething went wrong"
    case noObject = "Object not Found!"
    case unauthentificated = "The user is not authorised!\nPlease log in and try again"
    case anyError = "There's an error"
}

enum DownloadError : String, Error {
    case noUID = "Can't find UID"
    case snapError = "Something wrong with SnapShot"
}

enum FieldErrors : String, Error {
    case unfilledField = "Please fill in all fields!"
}

enum NoteErrors : String, Error {
    case empty = "Note is empty!\nPlease write something"
}


