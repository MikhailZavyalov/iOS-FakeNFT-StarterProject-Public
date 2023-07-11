import UIKit

final class DescriptionCollectionCell: UICollectionViewCell {

    static let identifier = "DescriptionCollectionCell"

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
        button.setTitleColor(.linkColor, for: .normal)
        button.titleLabel?.font = .caption2
        button.titleLabel?.tintColor = .linkColor
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
            collectionNameLabel.heightAnchor.constraint(equalToConstant: 28),

            creatorCollectonLabel.topAnchor.constraint(equalTo: collectionNameLabel.bottomAnchor, constant: 13),
            creatorCollectonLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            creatorCollectonLabel.widthAnchor.constraint(equalToConstant: 112),
            creatorCollectonLabel.heightAnchor.constraint(equalToConstant: 18),

            creatorCollectionButton.topAnchor.constraint(equalTo: collectionNameLabel.bottomAnchor, constant: 13),
            creatorCollectionButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 132),
            creatorCollectionButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            creatorCollectionButton.heightAnchor.constraint(equalToConstant: 18),

            descriptionCollectionLabel.topAnchor.constraint(equalTo: creatorCollectonLabel.bottomAnchor, constant: 5),
            descriptionCollectionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionCollectionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            descriptionCollectionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(
        title: String,
        subTitle: String,
        description: String,
        buttonTitle: String) {
            collectionNameLabel.text = title
            creatorCollectonLabel.text = subTitle
            creatorCollectionButton.setTitle(buttonTitle, for: .normal)
            descriptionCollectionLabel.text = description
    }
}
