import Foundation

protocol StatisticsUserNFTCollectionView: AnyObject {
    func setLoaderIsHidden(_ isHidden: Bool)
}

final class StatisticsUserNFTCollectionViewModel {
    @Observable
    var nfts: [StatisticsUserNFTCollectionCellModel] = []

    weak var view: StatisticsUserNFTCollectionView?

    private let model: StatisticsUserNFTCollectionModel
    private let router: StatisticsNavigation
    private let nftIDs: Set<String>
    private let likes: Set<String>

    init(model: StatisticsUserNFTCollectionModel, router: StatisticsNavigation, nftIDs: [String], likes: [String]) {
        self.model = model
        self.router = router
        self.nftIDs = Set(nftIDs)
        self.likes = Set(likes)
    }

    func viewDidLoad() {
        var nftIDsToLoad = nftIDs
        var loadedDictionary: [String: StatisticsUserNFTCollectionCellModel] = [:]

        view?.setLoaderIsHidden(false)

        nftIDs.forEach { id in
            model.loadNFT(id: id) { [weak self] result in
                guard let self else {
                    return
                }

                nftIDsToLoad.remove(id)

                switch result {
                case .success(let nftModel):
                    loadedDictionary[id] = StatisticsUserNFTCollectionCellModel(
                        nftModel: nftModel,
                        isLiked: self.likes.contains(id)
                    )
                case .failure(let error):
                    print(error)
                }

                if nftIDsToLoad.isEmpty {
                    DispatchQueue.main.async {
                        self.view?.setLoaderIsHidden(true)
                        self.nfts = Array(loadedDictionary.values)
                    }
                }
            }
        }
    }

    func didTapBack() {
        router.goBack()
    }
}
