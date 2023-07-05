import UIKit

final class UsersCollectionViewCell: UICollectionViewCell, ReuseIdentifying {

    var image: UIImage? {
        didSet {
            usersCollectionItemImage.image = image
        }
    }

    var rating: StarRating = .zero {
        didSet {
            switch rating {
            case .zero:
                usersCollectionItemRating.image = UIImage(named: "propertyZero")
            case .one:
                usersCollectionItemRating.image = UIImage(named: "propertyOne")
            case .two:
                usersCollectionItemRating.image = UIImage(named: "propertyTwo")
            case .three:
                usersCollectionItemRating.image = UIImage(named: "propertyThree")
            case .four:
                usersCollectionItemRating.image = UIImage(named: "propertyFour")
            case .five:
                usersCollectionItemRating.image = UIImage(named: "propertyFive")
            }
        }
    }

    var name: String? {
        didSet {
            usersCollectionItemName.text = name
        }
    }

    let usersCollectionItemImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 12
        return image
    }()

    let usersCollectionItemRating: UIImageView = {
        let rating = UIImageView()
        return rating
    }()

    let usersCollectionItemName: UILabel = {
        let name = UILabel()
        name.font = .systemFont(ofSize: 17, weight: .bold)
        return name
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(usersCollectionItemImage)
        usersCollectionItemImage.translatesAutoresizingMaskIntoConstraints = false

        addSubview(usersCollectionItemName)
        usersCollectionItemName.translatesAutoresizingMaskIntoConstraints = false

        addSubview(usersCollectionItemRating)
        usersCollectionItemRating.translatesAutoresizingMaskIntoConstraints = false

        let constraints = [
            usersCollectionItemImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            usersCollectionItemImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            usersCollectionItemImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),

            usersCollectionItemRating.topAnchor.constraint(equalTo: usersCollectionItemImage.bottomAnchor, constant: 8),
            usersCollectionItemRating.heightAnchor.constraint(equalToConstant: 12),
            usersCollectionItemRating.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),

            usersCollectionItemName.topAnchor.constraint(equalTo: usersCollectionItemRating.bottomAnchor, constant: 4),
            usersCollectionItemName.heightAnchor.constraint(equalToConstant: 22),
            usersCollectionItemName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        ]

        constraints.forEach {
            $0.priority = .defaultHigh
        }

        NSLayoutConstraint.activate(constraints)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func configureWith(model: UsersCollectionCellModel) {
        self.image = model.icon
        self.name = model.name
        self.rating = model.rating
    }
}
