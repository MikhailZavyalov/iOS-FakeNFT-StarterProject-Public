import Foundation

struct UserByIdRequest: NetworkRequest {
    let userId: String
    var endpoint: URL? {
        URL(string: "https://64858e8ba795d24810b71189.mockapi.io/api/v1/users/\(userId)")
    }
}
