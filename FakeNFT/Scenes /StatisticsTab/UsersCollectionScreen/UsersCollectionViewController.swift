import UIKit

final class UsersCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    let userCollection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    private let geometricParams = GeometricParams(cellCount: 3, leftInset: 16, rightInset: 16, cellSpacing: 9)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        userCollection.delegate = self
        userCollection.dataSource = self
        userCollection.register(UsersCollectionViewCell.self)

        configureNavigationBar()
        setupConstraints()
    }

    private func configureNavigationBar() {
        let backImage = UIImage(systemName: "chevron.backward")?
            .withTintColor(.black)
            .withRenderingMode(.alwaysOriginal)
        navigationItem.title = "Коллекция NFT"

        if self !== navigationController?.viewControllers.first {
            navigationItem.leftBarButtonItem = UIBarButtonItem(
                image: backImage,
                style: .plain,
                target: navigationController,
                action: #selector(UINavigationController.popViewController(animated:))
            )
        }
    }

    private func setupConstraints() {
        view.addSubview(userCollection)
        userCollection.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userCollection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            userCollection.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            userCollection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            userCollection.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        ])
    }
}

// MARK: - UICollectionViewDataSource
extension UsersCollectionViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UsersCollectionViewCell = userCollection.dequeueReusableCell(indexPath: indexPath)

        let model = UsersCollectionCellModel(
            icon: UIImage(named: "NFTcard")!,
            rating: .three,
            name: "Daddy"
        )

        cell.configureWith(model: model)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension UsersCollectionViewController {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = collectionView.frame.width - geometricParams.paddingWidth
        let cellWidth =  availableWidth / CGFloat(geometricParams.cellCount)
        return CGSize(width: cellWidth, height: cellWidth * 4 / 3)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: geometricParams.leftInset, bottom: 10, right: geometricParams.rightInset)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return geometricParams.cellSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return geometricParams.cellSpacing
    }
}
