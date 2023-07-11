import Foundation

struct OrderRequest: NetworkRequest {
    var endpoint: URL? {
        URL(string: "https://64a03ffded3c41bdd7a723cb.mockapi.io/api/v1/orders/1")
    }
}
