import Foundation
import UIKit

protocol Routable {
    var router: AppRouter? { get set }
}

class RoutableViewController: UIViewController, Routable {
    var router: AppRouter?
}

final class AppRouter {
    private var rootViewController: RoutableViewController?

    private var networkManager: NetworkManager?

    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }

    public func showMainScreen(with window: UIWindow?) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let initialViewController = storyboard.instantiateViewController(withIdentifier: "MainScreen") as? MainScreenViewController else {
            fatalError("Unable to Instantiate Main Screen View Controller")
        }
        initialViewController.networkManager = self.networkManager
        self.rootViewController = initialViewController
        guard let rootViewController = self.rootViewController else {
            return
        }
        rootViewController.router = self
        window?.rootViewController = initialViewController
        window?.makeKeyAndVisible()
    }

    public func showBiographyViewController() {
        let biographyViewController = BiographyViewController()
        biographyViewController.modalPresentationStyle = .fullScreen
        biographyViewController.networkManager = self.networkManager
        self.rootViewController?.present(biographyViewController, animated: true, completion: nil)
    }

    public func showBestTracksViewController() {
        let bestTracksViewController = BestTracksViewController()
        bestTracksViewController.networkManager = self.networkManager
        bestTracksViewController.modalPresentationStyle = .fullScreen
        self.rootViewController?.present(bestTracksViewController, animated: true, completion: nil)
    }
}
