import Foundation

struct CollectionModel {
    let user: User?
    let collection: CollectionsCatalogModel?
    let nfts: [NFT]?
    let order: Order?
    let profile: Profile?

    func nfts(by id: String) -> NFT? {
        nfts?.first { $0.id == id }
    }

    func isNFTinOrder(with nftId: String) -> Bool {
        order?.nfts.contains(nftId) == true
    }

    func isNFTLiked(with nftId: String) -> Bool {
        profile?.likes.contains(nftId) == true
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

struct NFT {
    let name: String
    let id: String
    let images: [String]
    let price: Float
    let rating: Int

    init(with nft: NFTNetworkModel) {
        self.name = nft.name
        self.images = nft.images
        self.id = nft.id
        self.price = nft.price
        self.rating = nft.rating
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

struct Profile {
    let name: String
    let avatar: String
    let description: String
    let website: String
    let nfts: [String]
    let likes: [String]
    let id: String

    init(with profile: ProfileNetworkModel) {
        self.name = profile.name
        self.avatar = profile.avatar
        self.description = profile.description
        self.website = profile.website
        self.nfts = profile.nfts
        self.likes = profile.likes
        self.id = profile.id
    }
}
