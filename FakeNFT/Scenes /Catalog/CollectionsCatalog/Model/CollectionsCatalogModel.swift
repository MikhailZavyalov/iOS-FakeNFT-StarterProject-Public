import Foundation

struct CollectionsCatalogModel {
    let createdAt: String
    let name: String
    let cover: String?
    let nfts: [String]
    let description: String
    let author: String
    let id: String

    var displayName: String {
        name + " (\(nfts.count))"
    }

    init(with collection: CollectionNetworkModel) {
        self.createdAt = collection.createdAt
        self.name = collection.name
        self.cover = collection.cover
        self.nfts = collection.nfts
        self.description = collection.description
        self.author = collection.author
        self.id = collection.id
    }
}
