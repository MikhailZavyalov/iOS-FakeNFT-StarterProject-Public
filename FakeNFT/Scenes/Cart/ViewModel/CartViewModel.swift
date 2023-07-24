import UIKit

protocol StatisticsView: AnyObject {
    func setLoaderIsHidden(_ isHidden: Bool)
}

final class CartViewModel {
    @Observable
    var NFTModels: [CartNFTModel] = []

    weak var view: StatisticsView?
    private let model: CartContentLoader

    init(model: CartContentLoader) {
        self.model = model
    }

    func viewDidLoad() {
        view?.setLoaderIsHidden(false)
        model.loadNFTs { result in
            DispatchQueue.main.async { [weak self] in
                guard let self else {
                    return
                }
                // loader
                self.view?.setLoaderIsHidden(true)

                switch result {
                case let .success(models):
                    let viewModelModels = models.map(CartNFTModel.init(serverModel:))
                    self.NFTModels = viewModelModels
                case let .failure(error):
                    print(error)
                }
            }
        }
    }

    func didDeleteNFT(index: Int) {
        NFTModels.remove(at: index)

        model.removeFromCart(id: "1", nfts: NFTModels.map { $0.id }) { result in
            DispatchQueue.main.async { [weak self] in
                guard let self else {
                    return
                }
                // loader
                self.view?.setLoaderIsHidden(true)

                switch result {
                case let .success(models):
                    print("Success")
                case let .failure(error):
                    print(error)
                }
            }
        }
    }

    func sortByPrice() {
        // Реализация сортировки по цене
        NFTModels.sort { $0.price < $1.price }
    }

    func sortByRating() {
        // Реализация сортировки по рейтингу
        NFTModels.sort { $0.rating > $1.rating }
    }

    func sortByName() {
        // Реализация сортировки по названию
        NFTModels.sort { $0.name < $1.name }
    }
}
