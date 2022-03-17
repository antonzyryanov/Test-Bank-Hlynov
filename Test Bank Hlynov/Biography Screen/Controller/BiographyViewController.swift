import UIKit

final class BiographyViewController: SearchViewController<BiographyView, InfoView> {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func performRequest(onCompletion: @escaping () -> Void) {
        guard let biographyView = self.view as? BiographyView else { return }
        guard let infoView = biographyView.responseView as? InfoView else { return }
        networkManager?.getInfo(about: self.artistName, artistInfoFetchedCompletionHandler: { artist in
            guard var artist = artist else {
                DispatchQueue.main.async {
                    onCompletion()
                    let alert = UIAlertController(title: "Artist not found", message: "", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
                return
            }
            if var lastFMArtistLink = artist.biography.summary.slice(from: "<a href=", to: "\">Read") {
                lastFMArtistLink.removeFirst()
                let stringToReplace = "<a href=\"" + lastFMArtistLink + "\">Read more on Last.fm</a>"
                artist.biography.summary = artist.biography.summary.replacingOccurrences(of: stringToReplace, with: lastFMArtistLink)
            }
            let artistImageURLString = artist.image[3].url
            guard let artistImageURL = URL(string: artistImageURLString) else { return }
            self.networkManager?.downloadImage(from: artistImageURL, completion: { image in
                DispatchQueue.main.async {
                    onCompletion()
                    infoView.isHidden = false
                    infoView.titleLabel.text = artist.name
                    infoView.infoTextView.text = artist.biography.summary
                    infoView.imageView.image = image
                }
            })
        })
    }
}
