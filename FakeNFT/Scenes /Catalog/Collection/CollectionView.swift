import UIKit

final class CollectionView: UIViewController {

    enum Section: Int, CaseIterable {
        case image
        case description
        case collection
    }

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(ImageCollectionCell.self,
                                forCellWithReuseIdentifier: ImageCollectionCell.identifier)
        collectionView.register(DescriptionCollectionCell.self,
                                forCellWithReuseIdentifier: DescriptionCollectionCell.identifier)
        collectionView.register(NFTCollectionCell.self,
                                forCellWithReuseIdentifier: NFTCollectionCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
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
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let section = Section(rawValue: indexPath.section) else { return UICollectionViewCell() }

        switch section {
        case .image:
            guard let imageCell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionCell.identifier, for: indexPath) as? ImageCollectionCell else {
                return UICollectionViewCell() }
            imageCell.configure(image: UIImage(named: "collectionImage"))
            return imageCell
        case .description:
            guard let descriptionCell = collectionView.dequeueReusableCell(withReuseIdentifier: DescriptionCollectionCell.identifier, for: indexPath) as? DescriptionCollectionCell else {
                return UICollectionViewCell() }
            descriptionCell.configure(
                title: "Peach",
                subTitle: "Автор коллекции:",
                description: "Персиковый — как облака над закатным солнцем в океане. В этой коллекции совмещены трогательная нежность и живая игривость сказочных зефирных зверей.",
                buttonTitle: "jkjskkml")
            return descriptionCell
        case .collection:
            guard let collectionNFTCell = collectionView.dequeueReusableCell(withReuseIdentifier: NFTCollectionCell.identifier, for: indexPath) as? NFTCollectionCell else {
                return UICollectionViewCell() }
            return collectionNFTCell
        }

    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        Section.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
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
            return CGSize(width: self.collectionView.bounds.width, height: 800)
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
}
