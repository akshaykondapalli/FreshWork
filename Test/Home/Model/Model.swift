// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Model
struct Model: Codable {
    var data: [Datum]?
}

// MARK: - Datum
struct Datum: Codable {
    let user: User?
    var isFav: Bool = false
    enum CodingKeys: String, CodingKey {
        case user
    }
}

// MARK: - User
struct User: Codable {
    let avatarURL: String?

    enum CodingKeys: String, CodingKey {
        case avatarURL = "avatar_url"
    }
}
