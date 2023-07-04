import UIKit

final class StatisticsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private let sortButton: UIButton = {
        let sortButton = UIButton()
        sortButton.setImage(UIImage(named: "Sort"), for: .normal)
        return sortButton
    }()

    private let tableView = UITableView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.register(StatisticsTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        sortButton.addTarget(self, action: #selector(statisticsFilter), for: .touchUpInside)

        setupConstraints()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: sortButton)
    }

    private func setupConstraints() {
        sortButton.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            sortButton.heightAnchor.constraint(equalToConstant: 42),
            sortButton.widthAnchor.constraint(equalToConstant: 42),

            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16)
        ])
    }

    @objc
    private func statisticsFilter() {
        let alert = UIAlertController(
            title: nil,
            message: "Cортировка",
            preferredStyle: .actionSheet
        )

        let nameAction = UIAlertAction(
            title: "По имени",
            style: .default
        ) { _ in
            alert.dismiss(animated: true)
        }

        let ratingAction = UIAlertAction(
            title: "По рейтингу",
            style: .default
        ) { _ in
            alert.dismiss(animated: true)
        }

        let closeAction = UIAlertAction(
            title: "Закрыть",
            style: .cancel) { _ in
                alert.dismiss(animated: true)
            }

        [nameAction, ratingAction, closeAction].forEach {
            alert.addAction($0)
        }

        present(alert, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension StatisticsViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: StatisticsTableViewCell = tableView.dequeueReusableCell()

        let model = StatisticsTableViewCellModel(
            number: 1,
            profilePhoto: UIImage(named: "profileTabBarImageActive")!,
            profileName: "Peter",
            profileNFTCount: 999)

        cell.configureWith(model: model)
        return cell
    }
}

extension StatisticsViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(UserCardViewController(), animated: true)
    }
}
