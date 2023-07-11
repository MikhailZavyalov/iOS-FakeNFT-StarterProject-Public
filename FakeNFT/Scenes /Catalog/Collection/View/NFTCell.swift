import UIKit

final class NFTCell: UICollectionViewCell {

    static let identifier = "NFTCell"

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
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var nftRaitingImageView: UIImageView = {
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
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(nftImageView)
        nftImageView.addSubview(likeOrDislikeButton)
        contentView.addSubview(nftRaitingImageView)
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

            nftRaitingImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nftRaitingImageView.topAnchor.constraint(equalTo: nftImageView.bottomAnchor, constant: 8),
            nftRaitingImageView.heightAnchor.constraint(equalToConstant: 12),
            nftRaitingImageView.widthAnchor.constraint(equalToConstant: 68),

            nameNFTLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameNFTLabel.topAnchor.constraint(equalTo: nftRaitingImageView.bottomAnchor, constant: 5),
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
}
