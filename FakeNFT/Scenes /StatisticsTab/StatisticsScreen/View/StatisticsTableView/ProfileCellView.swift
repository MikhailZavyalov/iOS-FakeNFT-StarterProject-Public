import UIKit

class ProfileCellView: UIView {
    var image: UIImage? {
        didSet {
            profilePhoto.image = image
        }
    }
    var text: String? {
        didSet {
            profileName.text = text
        }
    }
    var counter: Int? {
        didSet {
            profileNFTCount.text = counter.map { "\($0)" } ?? ""
        }
    }

    private let profilePhoto: UIImageView = {
        let profilePhoto = UIImageView()
        profilePhoto.layer.cornerRadius = 14
        profilePhoto.backgroundColor = .red
        return profilePhoto
    }()

    private let profileName: UILabel = {
        let profileName = UILabel()
        profileName.font = .systemFont(ofSize: 22, weight: .bold)
        profileName.textColor = .black
        return profileName
    }()

    private let profileNFTCount: UILabel = {
        let profileNFTCount = UILabel()
        profileNFTCount.font = .systemFont(ofSize: 22, weight: .bold)
        return profileNFTCount
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(hexString: "F7F7F8")
        layer.cornerRadius = 12

        let hStack = UIStackView(arrangedSubviews: [profilePhoto, profileName])
        hStack.translatesAutoresizingMaskIntoConstraints = false
        hStack.axis = .horizontal
        hStack.spacing = 8
        addSubview(hStack)

        addSubview(profileNFTCount)
        profileNFTCount.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            hStack.centerYAnchor.constraint(equalTo: centerYAnchor),
            profileNFTCount.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            profileNFTCount.centerYAnchor.constraint(equalTo: centerYAnchor),
            hStack.trailingAnchor.constraint(lessThanOrEqualTo: profileNFTCount.leadingAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
