import Foundation

struct OrderUpdateRequest: NetworkRequest {
    let orderUpdateDTO: OrderUpdateDTO
    var endpoint: URL? {
        URL(string: "https://64a03ffded3c41bdd7a723cb.mockapi.io/api/v1/orders/1")
    }

    var httpMethod: HttpMethod {
        .put
    }

    var dto: Encodable? {
        orderUpdateDTO
    }
}

struct OrderUpdateDTO: Encodable {
    let nfts: [String]
    let id: String
}
