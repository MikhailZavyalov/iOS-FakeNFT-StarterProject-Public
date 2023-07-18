import UIKit

final class CartViewModel {
    @Observable
    var NFTModels: [NFTModel] = []
    
    private let model: CartContentLoader
    
    init(model: CartContentLoader) {
        self.model = model
    }
    
    func viewDidLoad() {
        
        model.loadNFTs { result in
            DispatchQueue.main.async { [weak self] in
                guard let self else {
                    return
                }
                // loader
                
                switch result {
                case let .success(models):
                    let viewModelModels = models.map(NFTModel.init(serverModel:))
                    self.NFTModels = viewModelModels
                case let .failure(error):
                    print(error)
                }
            }
        }
    }
    
    func didDeleteNFT(index: Int) {
        NFTModels.remove(at: index)
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
