import UIKit

final class MainScreenViewController: RoutableViewController {
    var networkManager: NetworkManager?

    @IBOutlet weak var searchOfMusiciansLabel: UILabel!
    @IBOutlet weak var serviceDescription: UILabel!
    @IBOutlet weak var biographyOfArtistButton: UIButton!
    @IBOutlet weak var bestTracksButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCustomFonts()
    }
    
    private func setupCustomFonts() {
        searchOfMusiciansLabel.font = UIFont(name: "Roboto-Bold", size: 29)
        serviceDescription.font = UIFont(name: "Roboto-Regular", size: 16)
        biographyOfArtistButton.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 16)
        bestTracksButton.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 16)
    }

    @IBAction func biographyOfArtistButtonPressed(_ sender: Any) {
        self.router?.showBiographyViewController()
    }
    @IBAction func bestTracksButtonPressed(_ sender: Any) {
        self.router?.showBestTracksViewController()
    }
}
