import UIKit
import Kingfisher

final class UserCardViewController: UIViewController {
    private let usersAvatar: UIImageView = {
        let usersAvatar = UIImageView()
        usersAvatar.layer.cornerRadius = 35
        usersAvatar.layer.masksToBounds = true
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

    private let activityIndicator = UIActivityIndicatorView(style: .large)

    private let viewModel: UserCardViewModel

    init(viewModel: UserCardViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)

        viewModel.$profile.bind(executeInitially: true) { [weak self] profile in
            guard let self, let profile else {
                return
            }

            self.usersAvatar.kf.setImage(with: profile.avatar)
            self.userName.text = profile.name
            self.userDescription.text = profile.description
            self.usersCollectionButton.setTitle("Коллекция NFT (\(profile.nfts.count))", for: .normal)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        usersAvatar.kf.cancelDownloadTask()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        usersCollectionButton.addTarget(self, action: #selector(usersCollectionButtonTapped), for: .touchUpInside)
        usersWebsite.addTarget(self, action: #selector(websiteButtonTapped), for: .touchUpInside)

        setupConstraints()
        configureNavigationBar()

        viewModel.viewDidLoad()
    }

    func setLoaderIsHidden(_ isHidden: Bool) {
        if isHidden {
            activityIndicator.stopAnimating()
        } else {
            activityIndicator.startAnimating()
        }
    }

    private func setupConstraints() {
        view.addSubview(activityIndicator)
        activityIndicator.layer.zPosition = 9999
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

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
            usersAvatar.widthAnchor.constraint(equalToConstant: 70),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]

        constraints.forEach {
            $0.priority = .defaultHigh
        }

        NSLayoutConstraint.activate(constraints)
    }

    private func configureNavigationBar() {
        let backImage = UIImage(systemName: "chevron.backward")?
            .withTintColor(.black)
            .withRenderingMode(.alwaysOriginal)

        if self !== navigationController?.viewControllers.first {
            navigationItem.leftBarButtonItem = UIBarButtonItem(
                image: backImage,
                style: .plain,
                target: self,
                action: #selector(backButtonTapped)
            )
        }
    }

    // MARK: - Actions

    @objc
    private func usersCollectionButtonTapped() {
        viewModel.didTapNFTsCollection()
    }

    @objc
    private func websiteButtonTapped() {
        viewModel.didTapWebsite()
    }

    @objc
    private func backButtonTapped() {
        viewModel.didTapBack()
    }
}
