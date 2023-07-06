import Foundation

struct UserProfileModel: Decodable {
    let name: String
    let avatar: URL
    let description: String
    let website: URL
    let nfts: [String]
    let likes: [String]
    let id: String

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case avatar = "avatar"
        case description = "description"
        case website = "website"
        case nfts = "nfts"
        case likes = "likes"
        case id = "id"
    }
}

struct StatisticsUserProfileModel {
    let networkClient: NetworkClient

    func loadUser(id: String, completion: @escaping (Result<UserProfileModel, Error>) -> Void) {
        let request = DefaultNetworkRequest(
            endpoint: URL(string: "https://64858e8ba795d24810b71189.mockapi.io/api/v1/profile/\(id)")!
        )
        networkClient.send(request: request, type: UserProfileModel.self, onResponse: completion)
    }
}
