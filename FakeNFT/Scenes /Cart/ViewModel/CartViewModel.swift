import UIKit

final class CartViewModel {
    @Observable
    var NFTmodels: [NFTModel] = []
    
    private let model: CartModel
    
    init(model: CartModel) {
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
                    self.NFTmodels = viewModelModels
                case let .failure(error):
                    print(error)
                }
            }
        }
    }
    
    func didDeleteNFT(index: Int) {
        NFTmodels.remove(at: index)
    }
    
    func sortByPrice() {
        // Реализация сортировки по цене
        NFTmodels.sort { $0.price < $1.price }
    }

    func sortByRating() {
        // Реализация сортировки по рейтингу
        NFTmodels.sort { $0.rating > $1.rating }
    }

    func sortByName() {
        // Реализация сортировки по названию
        NFTmodels.sort { $0.name < $1.name }
    }
    
}
