import UIKit
import WebKit

protocol StatisticsNavigation {
    func goBack()
    func goToProfile(userID: String)
    func goToUserWebsite(url: URL)
    func goToUserNFTCollection(nftIDs: [String], likes: [String])
}

final class StatisticsRouter: StatisticsNavigation {
    weak var navigationController: UINavigationController?

    private let networkClient = DefaultNetworkClient()

    func goBack() {
        navigationController?.popViewController(animated: true)
    }

    func goToProfile(userID: String) {
        let profileViewController = assembleUserCardModule(userID: userID)
        navigationController?.pushViewController(profileViewController, animated: true)
    }

    func goToUserWebsite(url: URL) {
        let webKitViewController = assembleWKWebView(url: url)
        navigationController?.pushViewController(webKitViewController, animated: true)
    }

    func goToUserNFTCollection(nftIDs: [String], likes: [String]) {
        let collectionViewController = assembleUserCollectionModule(nftIDs: nftIDs, likes: likes)
        navigationController?.pushViewController(collectionViewController, animated: true)
    }
}

extension StatisticsRouter {
    func assembleStatisticsModule() -> UIViewController {
        let model = StatisticsModel(networkClient: networkClient)
        let viewModel = StatisticsViewModel(model: model, router: self)
        let view = StatisticsViewController(viewModel: viewModel)
        viewModel.view = view

        return view
    }
    
    private func assembleUserCardModule(userID: String) -> UIViewController {
        let model = StatisticsUserProfileModel(networkClient: networkClient)
        let viewModel = StatisticsUserProfileViewModel(id: userID, router: self, model: model)
        let view = StatisticsUserProfileViewController(viewModel: viewModel)

        return view
    }

    private func assembleUserCollectionModule(nftIDs: [String], likes: [String]) -> UIViewController {
        let model = StatisticsUserNFTCollectionModel(networkClient: networkClient)
        let viewModel = StatisticsUserNFTCollectionViewModel(
            model: model,
            router: self,
            nftIDs: nftIDs,
            likes: likes
        )
        let view = StatisticsUserNFTCollectionViewController(viewModel: viewModel)

        return view
    }

    private func assembleWKWebView(url: URL) -> UIViewController {
        WebViewController(url: url)
    }
}

private final class WebViewController: UIViewController {
    private let webView = WKWebView()

    init(url: URL) {
        super.init(nibName: nil, bundle: nil)
        let request = URLRequest(url: url)
        _ = webView.load(request)
    }

    override func loadView() {
        view = webView
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
