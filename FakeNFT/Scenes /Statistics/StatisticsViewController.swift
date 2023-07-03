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
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .white
        tableView.register(StatisticsTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self

        setupConstraints()
    }

    private func setupConstraints() {
        view.addSubview(sortButton)
        sortButton.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            sortButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -2),
            sortButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -9),
            sortButton.heightAnchor.constraint(equalToConstant: 42),
            sortButton.widthAnchor.constraint(equalToConstant: 42),

            tableView.topAnchor.constraint(equalTo: sortButton.bottomAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16)
        ])
    }

    private func sort() {

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
