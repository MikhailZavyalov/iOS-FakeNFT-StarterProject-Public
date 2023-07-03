import UIKit

final class StatisticsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private let tableView = UITableView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.register(StatisticsTableViewCell.self, forCellReuseIdentifier: StatisticsTableViewCell.reuseID)
        tableView.delegate = self
        tableView.dataSource = self

        setupConstraints()
    }

    private func setupConstraints() {
        view.addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16)
        ])
    }
}

// MARK: - UITableViewDataSource
extension StatisticsViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StatisticsTableViewCell.reuseID, for: indexPath)

        guard let statisticsViewCell = cell as? StatisticsTableViewCell else {
            return cell
        }

        let model = StatisticsTableViewCellModel(
            number: 1,
            profilePhoto: UIImage(named: "profileTabBarImageActive")!,
            profileName: "Peter",
            profileNFTCount: 999)

        statisticsViewCell.configureWith(model: model)
        return statisticsViewCell
    }
}
