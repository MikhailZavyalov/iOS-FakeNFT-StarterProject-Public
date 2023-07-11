import Foundation

final class CollectionViewModel: NSObject {
    private(set) var model: CollectionModel?

    var onChange: (() -> Void)?

    init(collection: CollectionsCatalogModel) {
        self.model = CollectionModel(user: self.model?.user, collection: collection)
        super.init()
        loadUserData(id: collection.author)
    }

    private func loadUserData(id: String) {
        DefaultNetworkClient().send(request: UserByIdRequest(userId: id), type: UserNetworkModel.self) { [weak self] result in
            switch result {
            case .success(let data):
                self?.model = CollectionModel(user: User(with: data), collection: self?.model?.collection)
                DispatchQueue.main.async {
                    self?.onChange?()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
