import UIKit

struct CartNFTModel: Hashable {
    let id: String
    let name: String
    let images: [URL]
    let price: Float
    let rating: Int
}

extension CartNFTModel {
    init(serverModel: NFTServerModel) {
        id = serverModel.id
        name = serverModel.name
        images = serverModel.images
        price = serverModel.price
        rating = serverModel.rating
    }
}
