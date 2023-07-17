import UIKit

protocol StatisticsView: AnyObject {
    func setLoaderIsHidden(_ isHidden: Bool)
}

enum SortType {
    case name
    case rating
}

final class StatisticsViewModel {
    @Observable
    var userModels: [UserModel] = []

    weak var view: StatisticsView?

    private let model: StatisticsModel
    private let router: StatisticsNavigation
    private var sorting: SortType = .rating {
        didSet {
            userModels = applySort(sorting, to: userModels)
        }
    }

    init(model: StatisticsModel, router: StatisticsRouter) {
        self.model = model
        self.router = router
    }

    func viewDidLoad() {
        view?.setLoaderIsHidden(false)
        model.loadUsers { result in
            DispatchQueue.main.async { [weak self] in
                guard let self else {
                    return
                }
                self.view?.setLoaderIsHidden(true)
                
                switch result {
                case let .success(models):
                    let viewModelModels = models.map(UserModel.init(serverModel:))
                    self.userModels = self.applySort(self.sorting, to: viewModelModels)
                case let .failure(error):
                    print(error)
                }
            }
        }
    }

    func didSelectCell(indexPath: IndexPath) {
        router.goToProfile(userID: userModels[indexPath.row].id)
    }

    func didSelectSort(_ sort: SortType) {
        sorting = sort
    }

    private func applySort(_ sort: SortType, to models: [UserModel]) -> [UserModel] {
        models.sorted { first, second in
            switch sort {
            case .name:
                return first.name < second.name
            case .rating:
                return first.rating < second.rating
            }
        }
    }
}
