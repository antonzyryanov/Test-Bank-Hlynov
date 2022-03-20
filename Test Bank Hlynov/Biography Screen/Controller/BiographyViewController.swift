import UIKit

final class BiographyViewController: SearchViewController<BiographyView, InfoView> {
    
    let textsLinksFormatter = TextsLinksFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupControllerUI()
    }
    
    private func setupControllerUI() {
        guard let biographyView = self.view as? BiographyView else { return }
        guard let infoView = biographyView.responseView as? InfoView else { return }
        infoView.imageView.image = UIImage(named: "artistImagePlaceholder")
        
        
    }

    override func performRequest(onCompletion: @escaping () -> Void) {
        guard let biographyView = self.view as? BiographyView else { return }
        guard let infoView = biographyView.responseView as? InfoView else { return }
        networkManager?.getInfo(about: self.artistName, artistInfoFetchedCompletionHandler: { artist in
            guard var artist = artist else {
                self.presentAlert(onCompletion: onCompletion)
                return
            }
            artist = self.textsLinksFormatter.formatLinksInBiography(of: artist)
            DispatchQueue.main.async {
                infoView.isHidden = false
                infoView.titleLabel.text = artist.name
                infoView.infoTextView.text = artist.biography.summary
            }
            let artistImageURLString = artist.image[3].url
            guard let artistImageURL = URL(string: artistImageURLString) else {
                DispatchQueue.main.async {
                    onCompletion()
                }
                return
            }
            self.networkManager?.downloadImage(from: artistImageURL, completion: { image in
                DispatchQueue.main.async {
                    onCompletion()
                    if image != nil{
                        infoView.imageView.image = image
                    }
                }
            })
        })
    }
}
