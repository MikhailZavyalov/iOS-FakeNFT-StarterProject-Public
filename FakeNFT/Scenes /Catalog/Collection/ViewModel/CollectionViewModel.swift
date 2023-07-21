import Foundation

final class CollectionViewModel: NSObject {
    let collection: CollectionNetworkModel

    var user: User?
    var nfts: [NFTNetworkModel]?
    var order: Order?
    var profile: ProfileNetworkModel?

    var onChange: (() -> Void)?
    var onError: ((String) -> Void)?

    init(collection: CollectionNetworkModel) {
        self.collection = collection
        super.init()
        loadAuthorData(id: collection.author)
        loadNFTData()
        loadOrderData()
        loadProfileData()
    }

    func reload() {
        let authorId = collection.author
        loadAuthorData(id: authorId)
        loadNFTData()
        loadOrderData()
        loadProfileData()
    }

    private func loadAuthorData(id: String) {
        DispatchQueue.global(qos: .background).async {
            DefaultNetworkClient().send(
                request: UserByIdRequest(userId: id),
                type: UserNetworkModel.self) { [weak self] result in
                    switch result {
                    case .success(let data):
                        self?.user = User(with: data)
                        DispatchQueue.main.async {
                            self?.onChange?()
                        }
                    case .failure(let error):
                        DispatchQueue.main.async {
                            self?.onError?(error.localizedDescription)
                        }
                    }
                }
        }
    }

    private func loadNFTData() {
        DispatchQueue.global(qos: .background).async {
            DefaultNetworkClient().send(request: NFTRequest(), type: [NFTNetworkModel].self) { [weak self] result in
                switch result {
                case .success(let data):
                    self?.nfts = data.map { $0 }
                    DispatchQueue.main.async {
                        self?.onChange?()
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.onError?(error.localizedDescription)
                    }
                }
            }
        }
    }

    private func loadOrderData() {
        DispatchQueue.global(qos: .background).async {
            DefaultNetworkClient().send(request: OrderRequest(), type: OrderNetworkModel.self) { [weak self] result in
                switch result {
                case .success(let data):
                    self?.order = Order(with: data)
                    DispatchQueue.main.async {
                        self?.onChange?()
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.onError?(error.localizedDescription)
                    }
                }
            }
        }
    }

    private func loadProfileData() {
        DispatchQueue.global(qos: .background).async {
            DefaultNetworkClient().send(
                request: ProfileRequest(),
                type: ProfileNetworkModel.self) { [weak self] result in
                switch result {
                case .success(let data):
                    self?.profile = data
                    DispatchQueue.main.async {
                        self?.onChange?()
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.onError?(error.localizedDescription)
                    }
                }
            }
        }
    }

    func toggleLikeForNFT(with id: String) {
        var likes = profile?.likes
        if let index = likes?.firstIndex(of: id) {
            likes?.remove(at: index)
        } else {
            likes?.append(id)
        }
        guard let likes = likes,
              let id = profile?.id else { return }
        let dto = ProfileUpdateDTO(likes: likes, id: id)
        updateProfileData(with: dto)
    }

    private func updateProfileData(with dto: ProfileUpdateDTO) {
        DispatchQueue.global(qos: .background).async {
            DefaultNetworkClient().send(
                request: ProfileUpdateRequest(profileUpdateDTO: dto),
                type: ProfileNetworkModel.self) { [weak self] result in
                    switch result {
                    case .success(let data):
                        self?.profile = data
                        DispatchQueue.main.async {
                            self?.onChange?()
                        }
                    case .failure(let error):
                        DispatchQueue.main.async {
                            self?.onError?(error.localizedDescription)
                        }
                    }
                }
        }
    }

    func toggleCartForNFT(with id: String) {
        var ntfs = order?.nfts
        if let index = ntfs?.firstIndex(of: id) {
            ntfs?.remove(at: index)
        } else {
            ntfs?.append(id)
        }
        guard let ntfs = ntfs,
              let id = order?.id else { return }
        let dto = OrderUpdateDTO(nfts: ntfs, id: id)
        updateOrderData(with: dto)
    }

    private func updateOrderData(with dto: OrderUpdateDTO) {
        DispatchQueue.global(qos: .background).async {
            DefaultNetworkClient().send(
                request: OrderUpdateRequest(orderUpdateDTO: dto),
                type: OrderNetworkModel.self) { [weak self] result in
                    switch result {
                    case .success(let data):
                        self?.order = Order(with: data)
                        DispatchQueue.main.async {
                            self?.onChange?()
                        }
                    case .failure(let error):
                        DispatchQueue.main.async {
                            self?.onError?(error.localizedDescription)
                        }
                    }
                }
        }
    }
}

extension CollectionViewModel {
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

extension Float {
    var asETHCurrency: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "ETH"
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
}
