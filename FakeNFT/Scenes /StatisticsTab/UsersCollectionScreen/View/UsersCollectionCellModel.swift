import UIKit

struct UsersCollectionCellModel {
    let icon: URL?
    let rating: StarRating
    let name: String
    let price: String
    let isLiked: Bool
}

enum StarRating: Int {
    case zero
    case one
    case two
    case three
    case four
    case five
}

extension UsersCollectionCellModel {
    init(nftModel: NFTModel, isLiked: Bool) {
        icon = nftModel.images.first
        rating = StarRating(rawValue: nftModel.rating) ?? .zero
        name = nftModel.name
        price = "\(nftModel.price) ETH"
        self.isLiked = isLiked
    }
}
