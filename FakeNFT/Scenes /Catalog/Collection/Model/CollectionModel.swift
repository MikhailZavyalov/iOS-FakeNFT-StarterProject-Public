import Foundation

struct CollectionModel {
    let user: User?
    let collection: CollectionsCatalogModel?
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
