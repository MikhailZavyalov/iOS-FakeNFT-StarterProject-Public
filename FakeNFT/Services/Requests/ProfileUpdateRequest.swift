import Foundation

struct ProfileUpdateRequest: NetworkRequest {

    let profileUpdateDTO: ProfileUpdateDTO
    var endpoint: URL? {
        URL(string: "https://64858e8ba795d24810b71189.mockapi.io/api/v1/profile/1")
    }

    var httpMethod: HttpMethod {
        .put
    }

    var dto: Encodable? {
        profileUpdateDTO
    }
}

struct ProfileUpdateDTO: Encodable {
    let likes: [String]
    let id: String
}
