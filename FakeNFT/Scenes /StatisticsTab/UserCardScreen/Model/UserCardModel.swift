import Foundation

struct UserProfileModel: Decodable {
    let name: String
    let avatar: URL
    let description: String
    let website: URL
    let nfts: [String]
    let likes: [String]
    let id: String

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case avatar = "avatar"
        case description = "description"
        case website = "website"
        case nfts = "nfts"
        case likes = "likes"
        case id = "id"
    }
}

struct UserCardModel {
    private enum NetworkError: Error {
        case someError
    }

    func loadUser(id: String, completion: @escaping (Result<UserProfileModel, Error>) -> Void) {
        let request = URLRequest(url: URL(string: "https://64858e8ba795d24810b71189.mockapi.io/api/v1/profile/\(id)")!)
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
                let models = try JSONDecoder().decode(UserProfileModel.self, from: data)
                completion(.success(models))
            } catch {
                return completion(.failure(error))
            }
        }
        task.resume()
    }
}
