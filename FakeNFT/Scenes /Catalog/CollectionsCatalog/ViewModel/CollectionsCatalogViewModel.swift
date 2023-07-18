import Foundation

final class CollectionsCatalogViewModel: NSObject {
    private(set) var collections: [CollectionsCatalogModel] = []
    var onChange: (() -> Void)?
    var onError: (() -> Void)?
    var onLoadingStarted: (() -> Void)?
    var onLoadingFinished: (() -> Void)?

    override init() {
        super.init()
    }

    func updateData() {
        loadData()
    }

    private func loadData() {
        let sort = UserDefaults.standard.string(forKey: "Sort")
        onLoadingStarted?()
        DefaultNetworkClient().send(
            request: CollectionsRequest(),
            type: [CollectionNetworkModel].self
        ) { [weak self] result in
            switch result {
            case .success(let data):
                self?.collections = data.map { CollectionsCatalogModel(with: $0) }
                DispatchQueue.main.async {
                    if sort == "byName" {
                        self?.sortByName()
                    } else {
                        self?.sortByNFT()
                    }
                    self?.onLoadingFinished?()
                    self?.onChange?()
                }
            case .failure:
                DispatchQueue.main.async {
                    self?.onError?()
                }
            }
        }
    }

        func sortByName() {
            collections = collections.sorted {
                $0.name < $1.name
            }
            UserDefaults.standard.set("byName", forKey: "Sort")
            onChange?()
        }

        func sortByNFT() {
            collections = collections.sorted {
                $0.nfts.count > $1.nfts.count
            }
            UserDefaults.standard.set("byNFT", forKey: "Sort")
            onChange?()
        }
    }
