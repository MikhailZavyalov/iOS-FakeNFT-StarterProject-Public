import UIKit

final class UserCardViewController: UIViewController {
    
    var image: UIImage? {
        didSet {
            usersAvatar.image = image
        }
    }

    var name: String? {
        didSet {
            userName.text = name
        }
    }

    var userDescriptionText: String? {
        didSet {
            userDescription.text = userDescriptionText
        }
    }

    var userNFTCountText: Int? {
        didSet {
            usersCollectionButton.setTitle("Коллекция NFT (\(userNFTCountText ?? 0))", for: .normal)
        }
    }

    private let usersAvatar: UIImageView = {
        let usersAvatar = UIImageView()
        usersAvatar.layer.cornerRadius = 35
        return usersAvatar
    }()

    private let userName: UILabel = {
        let userName = UILabel()
        userName.font = .systemFont(ofSize: 22, weight: .bold)
        return userName
    }()

    private let userDescription: UILabel = {
        let userDescription = UILabel()
        userDescription.font = .systemFont(ofSize: 13, weight: .regular)
        userDescription.numberOfLines = 0
        return userDescription
    }()

    private let usersWebsite: UIButton = {
        let usersWebsite = UIButton()
        usersWebsite.layer.cornerRadius = 16
        usersWebsite.layer.borderWidth = 1
        usersWebsite.layer.borderColor = UIColor(ciColor: .black).cgColor
        usersWebsite.setTitle("Перейти на сайт пользователя", for: .normal)
        usersWebsite.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
        usersWebsite.setTitleColor(.black, for: .normal)
        return usersWebsite
    }()

    private let usersCollectionButton: UIButton = {
        let usersCollectionButton = UIButton()
        usersCollectionButton.setTitleColor(.black, for: .normal)
        usersCollectionButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        let chevron = UIImage(systemName: "chevron.forward")?
            .withTintColor(.textPrimary)
            .withRenderingMode(.alwaysOriginal)
        let chevronImageView = UIImageView(image: chevron)
        usersCollectionButton.addSubview(chevronImageView)
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            usersCollectionButton.titleLabel!.leadingAnchor.constraint(equalTo: usersCollectionButton.leadingAnchor),
            chevronImageView.centerYAnchor.constraint(equalTo: usersCollectionButton.centerYAnchor),
            chevronImageView.trailingAnchor.constraint(equalTo: usersCollectionButton.trailingAnchor)
        ])
        return usersCollectionButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        let hStackAvatarAndName = UIStackView(arrangedSubviews: [usersAvatar, userName])
        hStackAvatarAndName.translatesAutoresizingMaskIntoConstraints = false
        hStackAvatarAndName.axis = .horizontal
        hStackAvatarAndName.spacing = 16

        let vStack = UIStackView(arrangedSubviews: [
            hStackAvatarAndName,
            VSpacer(height: 20),
            userDescription,
            VSpacer(height: 28),
            usersWebsite,
            VSpacer(height: 40),
            usersCollectionButton
        ])
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.axis = .vertical
        vStack.backgroundColor = .white
        view.addSubview(vStack)

        let constraints = [
            vStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            vStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            vStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            usersWebsite.heightAnchor.constraint(equalToConstant: 40),
            usersAvatar.heightAnchor.constraint(equalToConstant: 70),
            usersAvatar.widthAnchor.constraint(equalToConstant: 70)
        ]

        constraints.forEach {
            $0.priority = .defaultHigh
        }

        NSLayoutConstraint.activate(constraints)

        let model = UserCardDataModel(
            avatar: UIImage(named: "profileTabBarImageActive")!,
            name: "Peter The Beast",
            description: "Like big donations, simpsons and beer, cocks, asses and drugs7 literally programmer life style bitches fucken fuck you popo papa pipi nanana heeee heeee hello world and good by",
            usersNFTCount: 69)
        configureWith(model: model)
        configureNavigationBar()
    }

    private func configureWith(model: UserCardDataModel) {
        self.image = model.avatar
        self.name = model.name
        self.userDescriptionText = model.description
        self.userNFTCountText = model.usersNFTCount
    }

    private func configureNavigationBar() {
        let backImage = UIImage(systemName: "chevron.backward")?
            .withTintColor(.black)
            .withRenderingMode(.alwaysOriginal)

        if self !== navigationController?.viewControllers.first {
            navigationItem.leftBarButtonItem = UIBarButtonItem(
                image: backImage,
                style: .plain,
                target: navigationController,
                action: #selector(UINavigationController.popViewController(animated:))
            )
        }
    }
}
