import Foundation

struct UserModel: Decodable {
    let name: String
    let avatar: URL
    let description: String
    let website: URL
    let nfts: [String]
    let rating: Int
    let id: String

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case avatar = "avatar"
        case description = "description"
        case website = "website"
        case nfts = "nfts"
        case rating = "rating"
        case id = "id"
    }
}

private enum DecodingError: Error {
    case cantConvertStringToInt(String)
}

extension UserModel {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: UserModel.CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        avatar = try container.decode(URL.self, forKey: .avatar)
        description = try container.decode(String.self, forKey: .description)
        website = try container.decode(URL.self, forKey: .website)
        nfts = try container.decode([String].self, forKey: .nfts)
        id = try container.decode(String.self, forKey: .id)

        let strRating = try container.decode(String.self, forKey: .rating)
        if let rating = Int(strRating) {
            self.rating = rating
        } else {
            throw DecodingError.cantConvertStringToInt(strRating)
        }
    }
}
