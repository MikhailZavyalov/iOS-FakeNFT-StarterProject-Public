import UIKit
import Kingfisher

final class CollectionView: UIViewController {

    enum Section: Int, CaseIterable {
        case image
        case description
        case collection
    }

    enum Rating: Int {
        case zero = 0
        case one
        case two
        case three
        case four
        case five

        var image: UIImage? {
            switch self {
            case .zero:
                return UIImage(named: "zeroStar")
            case .one:
                return UIImage(named: "1Star")
            case .two:
                return UIImage(named: "2Star")
            case .three:
                return UIImage(named: "3Star")
            case .four:
                return UIImage(named: "4Star")
            case .five:
                return UIImage(named: "5Star")
            }
        }
    }

    private var model: CollectionModel? {
        viewModel.model
    }

    private let viewModel: CollectionViewModel

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(ImageCollectionCell.self,
                                forCellWithReuseIdentifier: ImageCollectionCell.identifier)
        collectionView.register(DescriptionCollectionCell.self,
                                forCellWithReuseIdentifier: DescriptionCollectionCell.identifier)
        collectionView.register(NFTCell.self,
                                forCellWithReuseIdentifier: NFTCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = .textPrimary
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()

    init(collection: CollectionsCatalogModel) {
        viewModel = CollectionViewModel(collection: collection)
        super.init(nibName: nil, bundle: nil)
        viewModel.onChange = self.collectionView.reloadData
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        addSubviews()
        setupLayout()
        makeNavBar()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInsetAdjustmentBehavior = .never
    }

    private func addSubviews() {
        view.addSubview(collectionView)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func makeNavBar() {
        if let navBar = navigationController?.navigationBar {
            let leftButton = UIBarButtonItem(
                image: UIImage(named: "chevronBackward"),
                style: .plain,
                target: self,
                action: #selector(self.didTapBackButton)
            )
            navigationItem.leftBarButtonItem = leftButton
            navBar.tintColor = .textPrimary
            navBar.isTranslucent = true
        }
    }

    @objc private func didTapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension CollectionView: UICollectionViewDelegate {

}

extension CollectionView: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {

        guard let section = Section(rawValue: indexPath.section) else { return UICollectionViewCell() }
        let collection = viewModel.model?.collection

        switch section {
        case .image:
            guard let imageCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ImageCollectionCell.identifier,
                for: indexPath) as? ImageCollectionCell else { return UICollectionViewCell() }

            if let imageURLString = collection?.cover,
               let imageURL = URL(string: imageURLString.encodeUrl) {
                imageCell.imageView.kf.setImage(with: imageURL)
            }
            return imageCell
        case .description:
            guard let descriptionCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: DescriptionCollectionCell.identifier,
                for: indexPath) as? DescriptionCollectionCell else { return UICollectionViewCell() }
            descriptionCell.configure(
                title: collection?.name ?? "",
                subTitle: "Автор коллекции: ",
                description: collection?.description ?? "",
                buttonTitle: model?.user?.name ?? "",
                buttonAction: linkAction)
            return descriptionCell
        case .collection:
            var likeOrDislikeButton: String
            var cartButton: String
            guard let collectionNFTCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: NFTCell.identifier,
                for: indexPath) as? NFTCell else { return UICollectionViewCell() }

            if let nftId = model?.collection?.nfts[indexPath.row],
               let imageURLString = model?.nfts(by: nftId)?.images.first,
               let imageURL = URL(string: imageURLString.encodeUrl),
               let price = model?.nfts(by: nftId)?.price,
               let rating = model?.nfts(by: nftId)?.rating,
               let ratingImage = Rating(rawValue: rating)?.image {

                likeOrDislikeButton = model?.isNFTLiked(with: nftId) == true ? "like" : "disLike"
                cartButton = model?.isNFTinOrder(with: nftId) == true ? "inCart" : "cart"
                collectionNFTCell.configure(
                    nftImage: imageURL,
                    likeOrDislakeImage: likeOrDislikeButton,
                    ratingImage: ratingImage,
                    title: model?.nfts(by: nftId)?.name ?? "",
                    price: "\(price) ETH",
                    cartImage: cartButton,
                    likeOrDislikeButtonAction: { [weak self] in
                        self?.likeOrDislikeButtonTapped(idNFT: nftId)
                    },
                    cartButtonAction: { [weak self] in
                    self?.cartButtonTapped(idNFT: nftId)
                })
            }
            return collectionNFTCell
        }
    }

    private func linkAction() {
        let webViewVC = WebViewView()
        guard let url = URL(string: model?.user?.website ?? "") else { return }
        webViewVC.url = url
        self.navigationController?.pushViewController(webViewVC, animated: true)
    }

    private func likeOrDislikeButtonTapped(idNFT: String) {
        viewModel.toggleLikeForNFT(with: idNFT)
    }

    private func cartButtonTapped(idNFT: String) {
        viewModel.toggleCartForNFT(with: idNFT)
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        Section.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else { return 0 }
        switch section {
        case .image:
            return 1
        case .description:
            return 1
        case .collection:
            return model?.collection?.nfts.count ?? 0
        }
    }
}

extension CollectionView: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        guard let section = Section(rawValue: indexPath.section) else { return .zero }
        switch section {
        case .image:
            return CGSize(width: self.collectionView.bounds.width, height: 310)
        case .description:
            return CGSize(width: self.collectionView.bounds.width, height: 136)
        case .collection:
            return CGSize(width: 108, height: 192)
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 0
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 0
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        guard let section = Section(rawValue: section) else { return .zero }
        switch section {
        case .image:
            return .zero
        case .description:
            return .zero
        case .collection:
            return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        }
    }
}
