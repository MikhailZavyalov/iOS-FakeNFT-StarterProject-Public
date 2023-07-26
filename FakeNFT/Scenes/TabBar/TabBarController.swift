import UIKit
import SwiftUI

class TabBarController: UITabBarController {
     override func viewDidLoad() {
        super.viewDidLoad()
    }

    class func configure() -> UIViewController {

        let profileVC = UINavigationController(rootViewController: ProfileViewController())
        profileVC.tabBarItem = UITabBarItem(
            title: "tabBarProfile".localized,
            image: UIImage(named: "profileTabBarImageNoActive"),
            selectedImage: UIImage(named: "profileTabBarImageActive"))

        let catalogVC = UINavigationController(
            rootViewController: CollectionsCatalogView(viewModel: CollectionsCatalogViewModel()))
        catalogVC.tabBarItem = UITabBarItem(
            title: "tabBarCatalog".localized,
            image: UIImage(named: "catalogTabBarImageNoActive"),
            selectedImage: UIImage(named: "catalogTabBarImageActive"))

        let cartVC = UINavigationController(rootViewController: assembleCartModule())
        cartVC.tabBarItem = UITabBarItem(
            title: "tabBarCart".localized,
            image: UIImage(named: "cartTabBarImageNoActive"),
            selectedImage: UIImage(named: "cartTabBarImageActive"))

        let statisticsRouter = StatisticsRouter()
        let statisticsVC = statisticsRouter.assembleStatisticsModule()
        let statisticsNavigationController = UINavigationController(rootViewController: statisticsVC)
        statisticsRouter.navigationController = statisticsNavigationController
        statisticsVC.tabBarItem = UITabBarItem(
            title: "tabBarStatistics".localized,
            image: UIImage(named: "statisticsTabBarImageNoActive"),
            selectedImage: UIImage(named: "statisticsTabBarImageActive"))

        let tabBarController = TabBarController()
        tabBarController.viewControllers = [profileVC, catalogVC, cartVC, statisticsNavigationController]
        tabBarController.tabBar.unselectedItemTintColor = .ypBlack
        tabBarController.tabBar.backgroundColor = .background
        tabBarController.tabBar.isTranslucent = false
        tabBarController.tabBar.clipsToBounds = true
        return tabBarController
    }
}

private func assembleCartModule() -> UIViewController {
    let cartModel: CartContentLoader = CartContentLoader(networkClient: DefaultNetworkClient())
    let cartViewModel: CartViewModel = CartViewModel(model: cartModel)

    return CartViewController(viewModel: cartViewModel)
}
