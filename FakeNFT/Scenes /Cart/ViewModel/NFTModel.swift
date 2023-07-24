import UIKit

struct NFTModel: Hashable {
    let id: String
    let name: String
    let images: [URL]
    let price: Float
    let rating: Int
}

extension NFTModel {
    init(serverModel: NFTServerModel) {
        id = serverModel.id
        name = serverModel.name
        images = serverModel.images
        price = serverModel.price
        rating = serverModel.rating
    }
}
