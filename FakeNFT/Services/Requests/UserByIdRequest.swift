import Foundation

struct UserByIdRequest: NetworkRequest {
    let userId: String
    var endpoint: URL? {
        URL(string: "https://64a03ffded3c41bdd7a723cb.mockapi.io/api/v1/users/\(userId)")
    }
}
