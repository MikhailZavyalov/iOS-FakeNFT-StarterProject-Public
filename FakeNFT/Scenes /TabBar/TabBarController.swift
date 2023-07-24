import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    class func configure() -> UIViewController {

        let profileVC = UINavigationController(rootViewController: ProfileViewController())
        profileVC.tabBarItem = UITabBarItem(
            title: "Профиль",
            image: UIImage(named: "profileTabBarImageNoActive"),
            selectedImage: UIImage(named: "profileTabBarImageActive"))

        let catalogVC = UINavigationController(
            rootViewController: CollectionsCatalogView(viewModel: CollectionsCatalogViewModel()))
        catalogVC.tabBarItem = UITabBarItem(
            title: "Каталог",
            image: UIImage(named: "catalogTabBarImageNoActive"),
            selectedImage: UIImage(named: "catalogTabBarImageActive"))

        let cartVC = UINavigationController(rootViewController: assembleCartModule())
        cartVC.tabBarItem = UITabBarItem(
            title: "Корзина",
            image: UIImage(named: "cartTabBarImageNoActive"),
            selectedImage: UIImage(named: "cartTabBarImageActive"))

        let statisticsVC = UINavigationController(rootViewController: StatisticsViewController())
        statisticsVC.tabBarItem = UITabBarItem(
            title: "Статистика",
            image: UIImage(named: "statisticsTabBarImageNoActive"),
            selectedImage: UIImage(named: "statisticsTabBarImageActive"))

        let tabBarController = TabBarController()
        tabBarController.viewControllers = [profileVC, catalogVC, cartVC, statisticsVC]
        tabBarController.tabBar.unselectedItemTintColor = .black
        tabBarController.tabBar.backgroundColor = .background

       return tabBarController
    }

}

private func assembleCartModule() -> UIViewController {
    let cartModel: CartContentLoader = CartContentLoader(networkClient: DefaultNetworkClient())
    let cartViewModel: CartViewModel = CartViewModel(model: cartModel)

    return CartViewController(viewModel: cartViewModel)
}
