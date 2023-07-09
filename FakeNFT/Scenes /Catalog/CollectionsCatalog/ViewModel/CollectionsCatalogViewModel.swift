import Foundation

final class CollectionsCatalogViewModel: NSObject {
    private(set) var collections: [CollectionsCatalogModel] = []
    var onChange: (() -> Void)?

    override init() {
        super.init()
        loadData()
    }

    private func loadData() {
        DefaultNetworkClient().send(request: CollectionsRequest(), type: [CollectionNetworkModel].self) { [weak self] result in
            switch result {
            case .success(let data):
                self?.collections = data.map { CollectionsCatalogModel(with: $0) }
                DispatchQueue.main.async {
                    self?.onChange?()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
