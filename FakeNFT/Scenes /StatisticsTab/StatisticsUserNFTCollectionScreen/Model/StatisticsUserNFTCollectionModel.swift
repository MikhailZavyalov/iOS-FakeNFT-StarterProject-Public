import Foundation

struct StatisticsUserNFTCollectionModel {
    private enum NetworkError: Error {
        case someError
    }

    let networkClient: NetworkClient

    func loadNFT(id: String, completion: @escaping (Result<NFTModel, Error>) -> Void) {
        let request = DefaultNetworkRequest(
            endpoint: Endpoint.getNFT(id: id)
        )
        networkClient.send(request: request, type: NFTModel.self, onResponse: completion)
    }
}
