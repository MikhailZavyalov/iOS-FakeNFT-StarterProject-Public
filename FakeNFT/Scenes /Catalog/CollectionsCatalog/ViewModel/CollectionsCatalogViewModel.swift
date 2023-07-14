import Foundation

final class CollectionsCatalogViewModel: NSObject {
    private(set) var collections: [CollectionsCatalogModel] = []
    var onChange: (() -> Void)?
    var onLoadingStarted: (() -> Void)?
    var onLoadingFinished: (() -> Void)?

    override init() {
        super.init()
    }

    public func updateData() {
        loadData()
    }

    private func loadData() {
        onLoadingStarted?()
        DefaultNetworkClient().send(
            request: CollectionsRequest(),
            type: [CollectionNetworkModel].self
        ) { [weak self] result in
            switch result {
            case .success(let data):
                self?.collections = data.map { CollectionsCatalogModel(with: $0) }
                DispatchQueue.main.async {
                    self?.sortByName()
                    self?.onLoadingFinished?()
                    self?.onChange?()
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    func sortByName() {
        collections = collections.sorted {
            $0.name < $1.name
        }
        onChange?()
    }

    func sortByNFT() {
        collections = collections.sorted {
            $0.nfts.count > $1.nfts.count
        }
        onChange?()
    }
}
