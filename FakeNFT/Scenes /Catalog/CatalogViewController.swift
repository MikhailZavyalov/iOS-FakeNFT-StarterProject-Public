import UIKit

final class CatalogViewController: UIViewController {

    private lazy var catalogTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CatalogTableViewCell.self, forCellReuseIdentifier: CatalogTableViewCell.identifier)
        tableView.backgroundColor = .white
        tableView.separatorColor = .white
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 8, right: 0)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
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
            navBar.tintColor = .black
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

extension CatalogViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let categoryCell = tableView.dequeueReusableCell(withIdentifier: CatalogTableViewCell.identifier) as? CatalogTableViewCell else {
            return UITableViewCell()
        }
        categoryCell.imageCategory.image = UIImage(named: "imageCategory")
        categoryCell.label.text = "Название категории"
        categoryCell.selectionStyle = .none
        return categoryCell
    }
}

extension CatalogViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 179
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let collectionVC = CollectionViewController()
        self.navigationController?.pushViewController(collectionVC, animated: true)

    }
}
