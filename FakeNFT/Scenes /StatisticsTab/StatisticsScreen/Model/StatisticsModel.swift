import Foundation

struct StatisticsModel {
    let networkClient: NetworkClient

    func loadUsers(completion: @escaping (Result<[ServerUserModel], Error>) -> Void) {
        let request = DefaultNetworkRequest(
            endpoint: URL(string: "https://64858e8ba795d24810b71189.mockapi.io/api/v1/users")!
        )
        networkClient.send(request: request, type: [ServerUserModel].self, onResponse: completion)
    }
}
