import UIKit

final class MainScreenViewController: RoutableViewController {
    var networkManager: NetworkManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }

    private func setupUI() {
        self.view = MainScreenView(firstOptionButtonAction: {
            self.router?.showBiographyViewController()
        }, secondOptionButtonAction: {
            self.router?.showBestTracksViewController()
        })
    }
}
