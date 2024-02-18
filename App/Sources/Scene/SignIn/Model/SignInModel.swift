import Foundation

struct SignInModel: Codable {
    var status: Int
    var data: UserData
  }

struct UserData: Codable {
    var accessToken: String
    var refreshToken: String
    var email: String
    var name: String
    var type: String
  }
