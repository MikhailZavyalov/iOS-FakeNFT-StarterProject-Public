import Foundation

struct UserCardViewModel {
    let name: String
    let avatar: URL
    let description: String
    let website: URL
    let nfts: [Int]

    private let router: StatisticsNavigation

    func didTapBack() {
        router.goBack()
    }

    func didTapWebsite() {
        router.goToUserWebsite(url: website)
    }

    func didTapNFTsCollection() {
        router.goToUserNFTCollection(nftIDs: nfts)
    }
}

extension UserCardViewModel {
    init(userModel: UserModel, router: StatisticsNavigation) {
        name = userModel.name
        avatar = userModel.avatar
        description = userModel.description
        website = userModel.website
        nfts = userModel.nfts

        self.router = router
    }
}
