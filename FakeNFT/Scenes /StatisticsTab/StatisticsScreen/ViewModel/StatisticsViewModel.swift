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
    private var sorting: SortType = .rating {
        didSet {
            userModels = applySort(sorting, to: userModels)
        }
    }

    init(model: StatisticsModel) {
        self.model = model
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
                    self.userModels = self.applySort(self.sorting, to: models)
                case let .failure(error):
                    print(error)
                }
            }
        }
    }

    func didSelectCell(indexPath: IndexPath) {
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
