import UIKit
import Kingfisher

extension String {
    var encodeUrl: String {
        return self.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
    }
    var decodeUrl: String {
        return self.removingPercentEncoding!
    }
}

final class CollectionsCatalogView: UIViewController {

    private var collections: [CollectionsCatalogModel] {
        viewModel.collections
    }
    private let viewModel: CollectionsCatalogViewModel

    private lazy var catalogTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CatalogTableViewCell.self, forCellReuseIdentifier: CatalogTableViewCell.identifier)
        tableView.backgroundColor = .background
        tableView.separatorColor = .background
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 8, right: 0)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    init() {
        viewModel = CollectionsCatalogViewModel()
        super.init(nibName: nil, bundle: nil)
        viewModel.onChange = self.catalogTableView.reloadData
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
    }

    private func addSubviews() {
        view.addSubview(catalogTableView)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            catalogTableView.topAnchor.constraint(equalTo: view.topAnchor),
            catalogTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            catalogTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            catalogTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func makeNavBar() {
        if let navBar = navigationController?.navigationBar {
            let rightButton = UIBarButtonItem(
                image: UIImage(named: "sortButton"),
                style: .plain,
                target: self,
                action: #selector(self.didTapSortButton)
            )
            navigationItem.rightBarButtonItem = rightButton
            navBar.tintColor = .textPrimary
        }
    }

    @objc private func didTapSortButton() {
        let alertSort = UIAlertController(
            title: "Сортировка",
            message: nil,
            preferredStyle: .actionSheet
        )
        let sortByNameAction = UIAlertAction(title: "По названию", style: .default) { _ in
          print("sortByNameAction")
        }
        let sortByNumberOfNFT = UIAlertAction(title: "По количеству NFT", style: .default) { _ in
          print("sortByNumberOfNFT")
        }
        let closeAlert = UIAlertAction(title: "Закрыть", style: .cancel) { _ in
        }
        alertSort.addAction(sortByNameAction)
        alertSort.addAction(sortByNumberOfNFT)
        alertSort.addAction(closeAlert)
        self.present(alertSort, animated: true, completion: nil)
    }
}

extension CollectionsCatalogView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        collections.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let categoryCell = tableView.dequeueReusableCell(withIdentifier: CatalogTableViewCell.identifier) as? CatalogTableViewCell else {
            return UITableViewCell()
        }
        let collection = collections[indexPath.row]
        if let imageURLString = collection.cover,
           let imageURL = URL(string: imageURLString.encodeUrl) {
            categoryCell.imageCategory.kf.setImage(with: imageURL)
        }

        categoryCell.label.text = collection.displayName
        categoryCell.selectionStyle = .none
        return categoryCell
    }
}

extension CollectionsCatalogView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 183
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let collectionVC = CollectionView(collection: collections[indexPath.row])
        self.navigationController?.pushViewController(collectionVC, animated: true)
     }
}
