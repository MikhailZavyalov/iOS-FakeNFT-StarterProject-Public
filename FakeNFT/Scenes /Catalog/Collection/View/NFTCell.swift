import UIKit
import Kingfisher

final class NFTCell: UICollectionViewCell {

    static let identifier = "NFTCell"
    let ratingMax = 5
    var onToggleLike: (() -> Void)?
    var onToggleCart: (() -> Void)?

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

    private lazy var nftRatingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 2
        stackView.alignment = .leading
        return stackView
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
        contentView.addSubview(nftImageView)
        contentView.addSubview(likeOrDislikeButton)
        contentView.addSubview(nftRatingStackView)
        contentView.addSubview(cartButton)
        contentView.addSubview(nameNFTLabel)
        contentView.addSubview(priceNFTLabel)

        for _ in 0..<ratingMax {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "star")
            nftRatingStackView.addArrangedSubview(imageView)
        }

        NSLayoutConstraint.activate([
            nftImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            nftImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nftImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nftImageView.heightAnchor.constraint(equalToConstant: 108),

            likeOrDislikeButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            likeOrDislikeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            likeOrDislikeButton.heightAnchor.constraint(equalToConstant: 40),
            likeOrDislikeButton.widthAnchor.constraint(equalToConstant: 40),

            nftRatingStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nftRatingStackView.topAnchor.constraint(equalTo: nftImageView.bottomAnchor, constant: 8),
            nftRatingStackView.heightAnchor.constraint(equalToConstant: 12),
            nftRatingStackView.widthAnchor.constraint(equalToConstant: 68),

            cartButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cartButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -28),
            cartButton.heightAnchor.constraint(equalToConstant: 40),
            cartButton.widthAnchor.constraint(equalToConstant: 40),

            nameNFTLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameNFTLabel.widthAnchor.constraint(equalToConstant: 68),
            nameNFTLabel.topAnchor.constraint(equalTo: nftRatingStackView.bottomAnchor, constant: 5),
            nameNFTLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -45),

            priceNFTLabel.topAnchor.constraint(equalTo: nameNFTLabel.bottomAnchor, constant: 4),
            priceNFTLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            priceNFTLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -29),
            priceNFTLabel.widthAnchor.constraint(equalToConstant: 68)
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

    // swiftlint:disable function_parameter_count
    func configure(
        nftImage: URL,
        likeOrDislakeImage: String,
        rating: Int,
        title: String,
        price: String,
        cartImage: String,
        likeOrDislikeButtonAction: @escaping () -> Void,
        cartButtonAction: @escaping () -> Void) {
            nftImageView.kf.setImage(with: nftImage)
            likeOrDislikeButton.setImage(UIImage(named: likeOrDislakeImage), for: .normal)
            setupRatingStackView(with: rating)
            nameNFTLabel.text = title
            priceNFTLabel.text = price
            cartButton.setImage(UIImage(named: cartImage), for: .normal)
            onToggleLike = likeOrDislikeButtonAction
            onToggleCart = cartButtonAction
        }
    // swiftlint:enable function_parameter_count

    func setupRatingStackView(with rating: Int) {
        for index in 0..<rating {
            guard let imageView = nftRatingStackView.subviews[index] as? UIImageView else {
                return
            }
            imageView.image = UIImage(named: "star_yellow")
        }
    }
}
