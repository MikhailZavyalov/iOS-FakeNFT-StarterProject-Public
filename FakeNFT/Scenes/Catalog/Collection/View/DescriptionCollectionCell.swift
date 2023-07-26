import UIKit

final class DescriptionCollectionCell: UICollectionViewCell {

    static let identifier = "DescriptionCollectionCell"
    var onTapped: (() -> Void)?

    private lazy var collectionNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textPrimary
        label.textAlignment = .left
        label.font = .headline3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var creatorCollectonLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textPrimary
        label.textAlignment = .left
        label.font = .caption2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var descriptionCollectionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textPrimary
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .caption2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var creatorCollectionButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.ypBlue, for: .normal)
        button.titleLabel?.font = .caption1
        button.titleLabel?.tintColor = .ypBlue
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.contentHorizontalAlignment = .left
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(collectionNameLabel)
        contentView.addSubview(creatorCollectonLabel)
        contentView.addSubview(creatorCollectionButton)
        contentView.addSubview(descriptionCollectionLabel)

        NSLayoutConstraint.activate([

            collectionNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            collectionNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            collectionNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            creatorCollectonLabel.topAnchor.constraint(equalTo: collectionNameLabel.bottomAnchor, constant: 13),
            creatorCollectonLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            creatorCollectonLabel.widthAnchor.constraint(equalToConstant: 112),
            creatorCollectonLabel.bottomAnchor.constraint(equalTo: descriptionCollectionLabel.topAnchor, constant: 5),

            creatorCollectionButton.topAnchor.constraint(equalTo: collectionNameLabel.bottomAnchor, constant: 12),
            creatorCollectionButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 132),
            creatorCollectionButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            creatorCollectionButton.bottomAnchor.constraint(equalTo: descriptionCollectionLabel.topAnchor, constant: 4),

            descriptionCollectionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionCollectionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            descriptionCollectionLabel.bottomAnchor.constraint(
                lessThanOrEqualTo: contentView.bottomAnchor, constant: -24)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func buttonTapped() {
        onTapped?()
    }

    func configure(
        title: String,
        subTitle: String,
        description: String,
        buttonTitle: String,
        buttonAction: @escaping () -> Void) {
            collectionNameLabel.text = title
            creatorCollectonLabel.text = subTitle
            creatorCollectionButton.setTitle(buttonTitle, for: .normal)
            descriptionCollectionLabel.text = description
            onTapped = buttonAction
    }
}
