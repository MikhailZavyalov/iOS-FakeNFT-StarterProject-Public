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

    func toggleLikeForNFT(with id: String) {
        var likes = model?.profile?.likes
        if let index = likes?.firstIndex(of: id) {
            likes?.remove(at: index)
        } else {
            likes?.append(id)
        }
        guard let likes = likes,
              let id = model?.profile?.id else { return }
        let dto = ProfileUpdateDTO(likes: likes, id: id)
        updateProfileData(with: dto)
    }

    private func updateProfileData(with dto: ProfileUpdateDTO) {
        DefaultNetworkClient().send(
            request: ProfileUpdateRequest(profileUpdateDTO: dto),
            type: ProfileNetworkModel.self) { [weak self] result in
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

    func toggleCartForNFT(with id: String) {
        var order = model?.order?.nfts
        if let index = order?.firstIndex(of: id) {
            order?.remove(at: index)
        } else {
            order?.append(id)
        }
        guard let order = order,
              let id = model?.order?.id else { return }
        let dto = OrderUpdateDTO(nfts: order, id: id)
        updateOrderData(with: dto)
    }

    private func updateOrderData(with dto: OrderUpdateDTO) {
        DefaultNetworkClient().send(
            request: OrderUpdateRequest(orderUpdateDTO: dto),
            type: OrderNetworkModel.self) { [weak self] result in
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
}
