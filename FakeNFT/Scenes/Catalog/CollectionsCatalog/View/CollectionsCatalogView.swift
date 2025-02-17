import UIKit

final class CollectionsCatalogView: UIViewController {

    private var collections: [CollectionNetworkModel] {
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

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = .textPrimary
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()

    init(viewModel: CollectionsCatalogViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.onChange = self.catalogTableView.reloadData
        viewModel.onError = { [weak self] error in
            self?.showErrorAlert(error: error)
        }
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
        viewModel.onLoadingStarted = self.startAnimating
        viewModel.onLoadingFinished = self.stopAnimating
        viewModel.updateData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.updateData()
    }

    private func addSubviews() {
        view.addSubview(catalogTableView)
        view.addSubview(activityIndicator)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            catalogTableView.topAnchor.constraint(equalTo: view.topAnchor),
            catalogTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            catalogTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            catalogTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            activityIndicator.widthAnchor.constraint(equalToConstant: 50),
            activityIndicator.heightAnchor.constraint(equalToConstant: 50),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
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
            title: "alertSortTitle".localized,
            message: nil,
            preferredStyle: .actionSheet
        )
        let sortByNameAction = UIAlertAction(title: "alertSortByName".localized, style: .default) { [weak self] _ in
            self?.viewModel.sortByName()
        }
        let sortByNumberOfNFT = UIAlertAction(title: "alertSortByNFT".localized, style: .default) { [weak self] _ in
            self?.viewModel.sortByNFT()
        }
        let closeAlert = UIAlertAction(title: "close".localized, style: .cancel)
        alertSort.addAction(sortByNameAction)
        alertSort.addAction(sortByNumberOfNFT)
        alertSort.addAction(closeAlert)
        self.present(alertSort, animated: true, completion: nil)
    }

    private func startAnimating() {
        activityIndicator.startAnimating()
    }

    private func stopAnimating() {
        activityIndicator.stopAnimating()
    }

    private func showErrorAlert(error: String) {
        let alertController = UIAlertController(
            title: "alertErrorTitle".localized,
            message: error,
            preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "no".localized, style: .default, handler: nil))
        alertController.addAction(UIAlertAction(title: "repeat".localized, style: .default, handler: { [weak self] _ in
            guard let self = self else { return }
            self.viewModel.updateData()
        }))
        present(alertController, animated: true, completion: nil)
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
        guard let categoryCell = tableView.dequeueReusableCell(
            withIdentifier: CatalogTableViewCell.identifier) as? CatalogTableViewCell else {
            return UITableViewCell()
        }
        let collection = collections[indexPath.row]
        if let imageURLString = collection.cover,
           let imageURL = URL(string: imageURLString.encodeUrl) {
            categoryCell.cofigure(image: imageURL, title: collection.displayName)
        }
        categoryCell.selectionStyle = .none
        return categoryCell
    }
}

extension CollectionsCatalogView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 183
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let collectionVC = NFTCollectionView(viewModel: CollectionViewModel(collection: collections[indexPath.row]))
        self.navigationController?.pushViewController(collectionVC, animated: true)
    }
}

extension String {
    var encodeUrl: String {
        guard let adding = self.addingPercentEncoding(
            withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else { return "" }
        return adding
    }
    var decodeUrl: String {
        guard let removing = self.removingPercentEncoding else { return ""}
        return removing
    }
}
