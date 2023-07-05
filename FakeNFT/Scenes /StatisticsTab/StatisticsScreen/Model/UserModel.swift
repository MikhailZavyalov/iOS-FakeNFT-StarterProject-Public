import Foundation

struct UserModel: Decodable {
    let name: String
    let avatar: URL
    let description: String
    let website: URL
    let nfts: [String]
    let rating: String
    let id: String
}
