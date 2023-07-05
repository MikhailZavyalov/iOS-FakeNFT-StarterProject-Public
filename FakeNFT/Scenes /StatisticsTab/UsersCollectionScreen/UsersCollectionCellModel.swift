import UIKit

struct UsersCollectionCellModel {
    let icon: UIImage
    let rating: StarRating
    let name: String
}

enum StarRating: Int {
    case zero
    case one
    case two
    case three
    case four
    case five
}
