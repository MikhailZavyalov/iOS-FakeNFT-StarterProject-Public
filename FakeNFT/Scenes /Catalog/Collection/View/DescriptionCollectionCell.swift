import UIKit

final class DescriptionCollectionCell: UICollectionViewCell {

    static let identifier = "DescriptionCollectionCell"
    var onTapped: (() -> Void)?

    private let gorizontalStackView = UIStackView()

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
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.contentHorizontalAlignment = .left
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        gorizontalStackView.axis = .horizontal
        gorizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(gorizontalStackView)
        gorizontalStackView.addSubview(collectionNameLabel)
        gorizontalStackView.addSubview(creatorCollectonLabel)
        gorizontalStackView.addSubview(creatorCollectionButton)
        gorizontalStackView.addSubview(descriptionCollectionLabel)

        NSLayoutConstraint.activate([

            gorizontalStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            gorizontalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            gorizontalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            gorizontalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),

            collectionNameLabel.topAnchor.constraint(equalTo: gorizontalStackView.topAnchor, constant: 16),
            collectionNameLabel.leadingAnchor.constraint(equalTo: gorizontalStackView.leadingAnchor, constant: 16),
            collectionNameLabel.trailingAnchor.constraint(equalTo: gorizontalStackView.trailingAnchor, constant: -16),
            collectionNameLabel.heightAnchor.constraint(equalToConstant: 28),

            creatorCollectonLabel.topAnchor.constraint(equalTo: collectionNameLabel.bottomAnchor, constant: 13),
            creatorCollectonLabel.leadingAnchor.constraint(equalTo: gorizontalStackView.leadingAnchor, constant: 16),
            creatorCollectonLabel.widthAnchor.constraint(equalToConstant: 112),
            creatorCollectonLabel.heightAnchor.constraint(equalToConstant: 18),

            creatorCollectionButton.topAnchor.constraint(equalTo: collectionNameLabel.bottomAnchor, constant: 13),
            creatorCollectionButton.leadingAnchor.constraint(equalTo: gorizontalStackView.leadingAnchor, constant: 132),
            creatorCollectionButton.trailingAnchor.constraint(equalTo: gorizontalStackView.trailingAnchor, constant: -16),
            creatorCollectionButton.heightAnchor.constraint(equalToConstant: 18),

            descriptionCollectionLabel.topAnchor.constraint(equalTo: creatorCollectonLabel.bottomAnchor, constant: 5),
            descriptionCollectionLabel.leadingAnchor.constraint(equalTo: gorizontalStackView.leadingAnchor, constant: 16),
            descriptionCollectionLabel.trailingAnchor.constraint(equalTo: gorizontalStackView.trailingAnchor, constant: -16),
            descriptionCollectionLabel.bottomAnchor.constraint(equalTo: gorizontalStackView.bottomAnchor)
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
