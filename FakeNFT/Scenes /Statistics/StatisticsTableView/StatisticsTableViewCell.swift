import UIKit

final class StatisticsTableViewCell: UITableViewCell, ReuseIdentifying {
    var profileCellAction: (() -> Void)?

    private var number: UILabel = {
        var number = UILabel()
        number.font = .systemFont(ofSize: 15, weight: .regular)
        number.textColor = .black
        return number
    }()

    private let coloredView = ProfileCellView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none

        contentView.addSubview(number)
        number.translatesAutoresizingMaskIntoConstraints = false


        coloredView.translatesAutoresizingMaskIntoConstraints = false

        let hStack = UIStackView(arrangedSubviews: [number, coloredView])
        hStack.translatesAutoresizingMaskIntoConstraints = false
        hStack.axis = .horizontal
        hStack.spacing = 12
        contentView.addSubview(hStack)

        let constraints = [
            hStack.topAnchor.constraint(equalTo: topAnchor),
            hStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            hStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            hStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 88),
            coloredView.heightAnchor.constraint(equalToConstant: 80)
        ]

        constraints.forEach {
            $0.priority = .defaultHigh
        }

        NSLayoutConstraint.activate(constraints)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureWith(model: StatisticsTableViewCellModel) {
        number.text = model.number.description
        coloredView.image = model.profilePhoto
        coloredView.text = model.profileName
        coloredView.counter = model.profileNFTCount
    }

    @objc private func profileCellTapped() {
        profileCellAction?()
    }
}
