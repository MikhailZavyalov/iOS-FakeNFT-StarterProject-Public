import UIKit

struct UsersCollectionCellModel {
    let icon: UIImage
    let rating: StarRating
    let name: String
    let price: String
    let card: UIImage
    let favorive: UIImage
}

enum StarRating: Int {
    case zero
    case one
    case two
    case three
    case four
    case five
}
