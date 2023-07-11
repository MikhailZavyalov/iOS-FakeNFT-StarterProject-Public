import Foundation

final class CollectionViewModel: NSObject {
    private(set) var model: CollectionModel?

    var onChange: (() -> Void)?

    init(collection: CollectionsCatalogModel) {
        self.model = CollectionModel(
            user: self.model?.user,
            collection: collection,
            nfts: self.model?.nfts,
            order: self.model?.order,
            profile: self.model?.profile
        )
        super.init()
        loadAuthorData(id: collection.author)
        loadNFTData()
        loadOrderData()
        loadProfileData()
    }

    private func loadAuthorData(id: String) {
        DefaultNetworkClient().send(
            request: UserByIdRequest(userId: id),
            type: UserNetworkModel.self) { [weak self] result in
            switch result {
            case .success(let data):
                self?.model = CollectionModel(
                    user: User(with: data),
                    collection: self?.model?.collection,
                    nfts: self?.model?.nfts,
                    order: self?.model?.order,
                    profile: self?.model?.profile
                )
                DispatchQueue.main.async {
                    self?.onChange?()
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    private func loadNFTData() {
        DefaultNetworkClient().send(request: NFTRequest(), type: [NFTNetworkModel].self) { [weak self] result in
            switch result {
            case .success(let data):
                self?.model = CollectionModel(
                    user: self?.model?.user,
                    collection: self?.model?.collection,
                    nfts: data.map { NFT(with: $0) },
                    order: self?.model?.order,
                    profile: self?.model?.profile
                )
                DispatchQueue.main.async {
                    self?.onChange?()
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    private func loadOrderData() {
        DefaultNetworkClient().send(request: OrderRequest(), type: OrderNetworkModel.self) { [weak self] result in
            switch result {
            case .success(let data):
                self?.model = CollectionModel(
                    user: self?.model?.user,
                    collection: self?.model?.collection,
                    nfts: self?.model?.nfts,
                    order: Order(with: data),
                    profile: self?.model?.profile
                )
                DispatchQueue.main.async {
                    self?.onChange?()
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    private func loadProfileData() {
        DefaultNetworkClient().send(request: ProfileRequest(), type: ProfileNetworkModel.self) { [weak self] result in
            switch result {
            case .success(let data):
                self?.model = CollectionModel(
                    user: self?.model?.user,
                    collection: self?.model?.collection,
                    nfts: self?.model?.nfts,
                    order: self?.model?.order,
                    profile: Profile(with: data)
                )
                DispatchQueue.main.async {
                    self?.onChange?()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
