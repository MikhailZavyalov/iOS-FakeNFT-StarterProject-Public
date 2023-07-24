import Foundation

let ordersAPI: String = "https://64858e8ba795d24810b71189.mockapi.io/api/v1/orders/1"
let nftAPI: String = "https://64858e8ba795d24810b71189.mockapi.io/api/v1/nft/"

struct CartContentLoader {
    let networkClient: NetworkClient

    func loadNFTs(completion: @escaping (Result<[NFTServerModel], Error>) -> Void) {
        loadCart { cartResult in
            switch cartResult {
            case .success(let cartServerModel):
                var nfts: [NFTServerModel] = []
                cartServerModel.nfts.forEach { nftID in
                    loadNFT(id: nftID) { nftResult in
                        switch nftResult {
                        case .success(let nft):
                            nfts.append(nft)
                            if nfts.count == cartServerModel.nfts.count {
                                completion(.success(nfts))
                            }
                        case .failure(let error):
                            print(error)
                            completion(.failure(error))
                        }
                    }
                }
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
        }
    }

    private func loadCart(completion: @escaping (Result<CartServerModel, Error>) -> Void) {
        let request = DefaultNetworkRequest(
            endpoint: URL(string: ordersAPI)!, dto: nil, httpMethod: .get
        )
        networkClient.send(request: request, type: CartServerModel.self, onResponse: completion)
    }

    private func loadNFT(id: String, completion: @escaping (Result<NFTServerModel, Error>) -> Void) {
        let request = DefaultNetworkRequest(
            endpoint: URL(string: nftAPI + "\(id)")!, dto: nil, httpMethod: .get
        )
        networkClient.send(request: request, type: NFTServerModel.self, onResponse: completion)
    }

    func removeFromCart(id: String, nfts: [String], completion: @escaping (Result<CartUpdateModel, Error>) -> Void) {
        let request = DefaultNetworkRequest(
            endpoint: URL(string: ordersAPI)!, dto: CartUpdateModel(nfts: nfts, id: id), httpMethod: .put
        )

        DefaultNetworkClient().send(
            request: request,
            type: CartUpdateModel.self, onResponse: completion)
    }
}

struct CartUpdateModel: Codable {
    let nfts: [String]
    let id: String
}
