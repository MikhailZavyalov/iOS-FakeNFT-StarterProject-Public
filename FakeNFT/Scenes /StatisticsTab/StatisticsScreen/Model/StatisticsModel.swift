import Foundation
//
//private let mockModels = [
//    UserModel(
//        name: "Elijah Anderson",
//        avatar: URL(string: "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/179.jpg")!,
//        description: "NFT collector and enthusiast 🚀",
//        website: URL(string: "https://practicum.yandex.ru/qa-engineer/")!,
//        nfts: [
//            1,
//            4,
//            6,
//            8
//        ],
//        rating: 77,
//        id: 1
//    )
//]

struct StatisticsModel {
    private enum NetworkError: Error {
        case someError
    }

    func loadUsers(completion: @escaping (Result<[UserModel], Error>) -> Void) {
        let request = URLRequest(url: URL(string: "https://64858e8ba795d24810b71189.mockapi.io/api/v1/users")!)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
                return completion(.failure(error))
            }

            if let response = response as? HTTPURLResponse,
               !(200..<300).contains(response.statusCode) {
                return completion(.failure(NetworkError.someError))
            }

            guard let data else {
                return completion(.failure(NetworkError.someError))
            }

            do {
                let models = try JSONDecoder().decode([UserModel].self, from: data)
                completion(.success(models))
            } catch {
                return completion(.failure(error))
            }
        }
        task.resume()
    }
}
