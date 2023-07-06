import UIKit

protocol StatisticsNavigation {
    func goBack()
    func goToProfile(user: UserModel)
    func goToUserWebsite(url: URL)
    func goToUserNFTCollection(nftIDs: [Int])
}

final class StatisticsRouter: StatisticsNavigation {
    weak var navigationController: UINavigationController?

    func goBack() {
        navigationController?.popViewController(animated: true)
    }

    func goToProfile(user: UserModel) {
    }

    func goToUserWebsite(url: URL) {
        // TODO: - Push WKWebView
    }

    func goToUserNFTCollection(nftIDs: [Int]) {

    }
}

extension StatisticsRouter {
    func assembleStatisticsModule() -> UIViewController {
        let model = StatisticsModel()
        let viewModel = StatisticsViewModel(model: model, router: self)
        let view = StatisticsViewController(viewModel: viewModel)
        viewModel.view = view

        return view
    }
}
