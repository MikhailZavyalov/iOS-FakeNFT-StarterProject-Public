import Foundation

protocol UserCardView: AnyObject {
    func setLoaderIsHidden(_ isHidden: Bool)
}

final class StatisticsUserProfileViewModel {
    @Observable
    var profile: UserProfileModel?

    weak var view: UserCardView?

    private let id: String
    private let router: StatisticsNavigation
    private let model: StatisticsUserProfileModel

    init(id: String, router: StatisticsNavigation, model: StatisticsUserProfileModel) {
        self.id = id
        self.router = router
        self.model = model
    }

    func viewDidLoad() {
        view?.setLoaderIsHidden(false)
        model.loadUser(id: id) { result in
            DispatchQueue.main.async { [weak self] in
                guard let self else {
                    return
                }

                self.view?.setLoaderIsHidden(true)

                switch result {
                case .success(let profile):
                    self.profile = profile
                case .failure(let error):
                    print(error)
                }
            }
        }
    }

    func didTapBack() {
        router.goBack()
    }

    func didTapWebsite() {
        guard let url = profile?.website else {
            return
        }

        router.goToUserWebsite(url: url)
    }

    func didTapNFTsCollection() {
        guard let profile else {
            return
        }

        router.goToUserNFTCollection(nftIDs: profile.nfts, likes: profile.likes)
    }
}
