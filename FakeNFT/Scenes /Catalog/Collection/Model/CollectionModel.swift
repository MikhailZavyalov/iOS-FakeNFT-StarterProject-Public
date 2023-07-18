import Foundation

struct CollectionModel {
    let user: User?
    let collection: CollectionsCatalogModel?
    let nfts: [NFTNetworkModel]?
    let order: Order?
    let profile: ProfileNetworkModel?

    func nfts(by id: String) -> NFTNetworkModel? {
        nfts?.first { $0.id == id }
    }

    func isNFTinOrder(with nftId: String) -> Bool {
        return order?.nfts.contains(nftId) ?? false
    }

    func isNFTLiked(with nftId: String) -> Bool {
        return profile?.likes.contains(nftId) ?? false
    }
}

struct User {
    let name: String
    let website: String
    let id: String

    init(with user: UserNetworkModel) {
        self.name = user.name
        self.website = user.website
        self.id = user.id
    }
}

struct Order {
    let nfts: [String]
    let id: String

    init(with nft: OrderNetworkModel) {
        self.nfts = nft.nfts
        self.id = nft.id
    }
}
