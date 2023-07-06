import Foundation

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
