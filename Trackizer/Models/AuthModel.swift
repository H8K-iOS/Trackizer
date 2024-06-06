import Foundation

//MARK: - Registration Model
struct RegisterUserRequest {
    let userName: String
    let email: String
    let password: String
}

//MARK: - Login Model
struct LoginUserRequest {
    let email: String
    let password: String
}

