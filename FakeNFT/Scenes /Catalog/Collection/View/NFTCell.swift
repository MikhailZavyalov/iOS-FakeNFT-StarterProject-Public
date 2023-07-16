import UIKit
import Kingfisher

final class NFTCell: UICollectionViewCell {

    static let identifier = "NFTCell"
    var onToggleLike: (() -> Void)?
    var onToggleCart: (() -> Void)?

    lazy var nftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 12
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()

    lazy var likeOrDislikeButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var nftRatingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var nameNFTLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textPrimary
        label.textAlignment = .left
        label.font = .bodyBold
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var priceNFTLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textPrimary
        label.textAlignment = .left
        label.font = .caption3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var cartButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(cartButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(nftImageView)
        contentView.addSubview(likeOrDislikeButton)
        contentView.addSubview(nftRatingImageView)
        contentView.addSubview(nameNFTLabel)
        contentView.addSubview(priceNFTLabel)
        contentView.addSubview(cartButton)

        NSLayoutConstraint.activate([
            nftImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            nftImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nftImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nftImageView.heightAnchor.constraint(equalToConstant: 108),
            nftImageView.widthAnchor.constraint(equalToConstant: 108),

            likeOrDislikeButton.topAnchor.constraint(equalTo: nftImageView.topAnchor),
            likeOrDislikeButton.trailingAnchor.constraint(equalTo: nftImageView.trailingAnchor),
            likeOrDislikeButton.heightAnchor.constraint(equalToConstant: 40),
            likeOrDislikeButton.widthAnchor.constraint(equalToConstant: 40),

            nftRatingImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nftRatingImageView.topAnchor.constraint(equalTo: nftImageView.bottomAnchor, constant: 8),
            nftRatingImageView.heightAnchor.constraint(equalToConstant: 12),
            nftRatingImageView.widthAnchor.constraint(equalToConstant: 68),

            nameNFTLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameNFTLabel.topAnchor.constraint(equalTo: nftRatingImageView.bottomAnchor, constant: 5),
            nameNFTLabel.heightAnchor.constraint(equalToConstant: 22),
            nameNFTLabel.widthAnchor.constraint(equalToConstant: 68),

            priceNFTLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            priceNFTLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            priceNFTLabel.heightAnchor.constraint(equalToConstant: 12),
            priceNFTLabel.widthAnchor.constraint(equalToConstant: 68),

            cartButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cartButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            cartButton.heightAnchor.constraint(equalToConstant: 40),
            cartButton.widthAnchor.constraint(equalToConstant: 40)

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
