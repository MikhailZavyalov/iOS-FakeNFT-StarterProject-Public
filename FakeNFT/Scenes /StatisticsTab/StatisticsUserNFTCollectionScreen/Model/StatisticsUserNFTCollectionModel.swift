import Foundation

struct StatisticsUserNFTCollectionModel {
    private enum NetworkError: Error {
        case someError
    }

    let networkClient: NetworkClient

    func loadNFT(id: String, completion: @escaping (Result<NFTModel, Error>) -> Void) {
        let request = DefaultNetworkRequest(
            endpoint: URL(string: "https://64858e8ba795d24810b71189.mockapi.io/api/v1/nft/\(id)")!
        )
        networkClient.send(request: request, type: NFTModel.self, onResponse: completion)
    }
}
