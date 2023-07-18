import UIKit
import Kingfisher

final class NFTCell: UICollectionViewCell {

    static let identifier = "NFTCell"
    var onToggleLike: (() -> Void)?
    var onToggleCart: (() -> Void)?

    private let mainStackView = UIStackView()
    private let verticalStackView = UIStackView()
    private let informationStackView = UIStackView()

    private lazy var nftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 12
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var likeOrDislikeButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var nftRatingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var nameNFTLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textPrimary
        label.textAlignment = .left
        label.font = .bodyBold
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var priceNFTLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textPrimary
        label.textAlignment = .left
        label.font = .caption3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var cartButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(cartButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        mainStackView.axis = .horizontal
        mainStackView.translatesAutoresizingMaskIntoConstraints = false

        verticalStackView.axis = .vertical
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false

        informationStackView.axis = .horizontal
        informationStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(mainStackView)

        mainStackView.addSubview(nftImageView)
        mainStackView.addSubview(likeOrDislikeButton)
        mainStackView.addSubview(verticalStackView)

        verticalStackView.addSubview(informationStackView)
        verticalStackView.addSubview(cartButton)

        informationStackView.addSubview(nftRatingImageView)
        informationStackView.addSubview(nameNFTLabel)
        informationStackView.addSubview(priceNFTLabel)

        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            nftImageView.topAnchor.constraint(equalTo: mainStackView.topAnchor),
            nftImageView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            nftImageView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            nftImageView.heightAnchor.constraint(equalToConstant: 108),

            likeOrDislikeButton.topAnchor.constraint(equalTo: mainStackView.topAnchor),
            likeOrDislikeButton.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            likeOrDislikeButton.heightAnchor.constraint(equalToConstant: 40),
            likeOrDislikeButton.widthAnchor.constraint(equalToConstant: 40),

            verticalStackView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            verticalStackView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            verticalStackView.topAnchor.constraint(equalTo: nftImageView.bottomAnchor),
            verticalStackView.heightAnchor.constraint(equalToConstant: 92),

            cartButton.trailingAnchor.constraint(equalTo: verticalStackView.trailingAnchor),
            cartButton.bottomAnchor.constraint(equalTo: verticalStackView.bottomAnchor, constant: -28),
            cartButton.heightAnchor.constraint(equalToConstant: 40),
            cartButton.widthAnchor.constraint(equalToConstant: 40),

            informationStackView.trailingAnchor.constraint(equalTo: cartButton.leadingAnchor),
            informationStackView.leadingAnchor.constraint(equalTo: verticalStackView.leadingAnchor),
            informationStackView.topAnchor.constraint(equalTo: verticalStackView.topAnchor),
            informationStackView.bottomAnchor.constraint(equalTo: verticalStackView.bottomAnchor),

            nftRatingImageView.leadingAnchor.constraint(equalTo: informationStackView.leadingAnchor),
            nftRatingImageView.topAnchor.constraint(equalTo: informationStackView.topAnchor, constant: 8),
            nftRatingImageView.heightAnchor.constraint(equalToConstant: 12),
            nftRatingImageView.widthAnchor.constraint(equalToConstant: 68),

            nameNFTLabel.leadingAnchor.constraint(equalTo: informationStackView.leadingAnchor),
            nameNFTLabel.trailingAnchor.constraint(equalTo: informationStackView.trailingAnchor),
            nameNFTLabel.topAnchor.constraint(equalTo: nftRatingImageView.bottomAnchor, constant: 5),
            nameNFTLabel.heightAnchor.constraint(equalToConstant: 22),

            priceNFTLabel.leadingAnchor.constraint(equalTo: informationStackView.leadingAnchor),
            priceNFTLabel.bottomAnchor.constraint(equalTo: informationStackView.bottomAnchor, constant: -29),
            priceNFTLabel.topAnchor.constraint(equalTo: nameNFTLabel.bottomAnchor, constant: 4),
            priceNFTLabel.trailingAnchor.constraint(equalTo: informationStackView.trailingAnchor),
            priceNFTLabel.heightAnchor.constraint(equalToConstant: 12)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func likeButtonTapped() {
        onToggleLike?()
    }

    @objc private func cartButtonTapped() {
        onToggleCart?()
    }

    func configure(
        nftImage: URL,
        likeOrDislakeImage: String,
        ratingImage: UIImage,
        title: String,
        price: String,
        cartImage: String,
        likeOrDislikeButtonAction: @escaping () -> Void,
        cartButtonAction: @escaping () -> Void) {
            nftImageView.kf.setImage(with: nftImage)
            likeOrDislikeButton.setImage(UIImage(named: likeOrDislakeImage), for: .normal)
            nftRatingImageView.image =  ratingImage
            nameNFTLabel.text = title
            priceNFTLabel.text = price
            cartButton.setImage(UIImage(named: cartImage), for: .normal)
            onToggleLike = likeOrDislikeButtonAction
            onToggleCart = cartButtonAction
        }
}
