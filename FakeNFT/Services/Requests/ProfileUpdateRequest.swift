import Foundation

struct ProfileUpdateRequest: NetworkRequest {

    let profileUpdateDTO: ProfileUpdateDTO
    var endpoint: URL? {
        URL(string: "https://64a03ffded3c41bdd7a723cb.mockapi.io/api/v1/profile/1")
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
