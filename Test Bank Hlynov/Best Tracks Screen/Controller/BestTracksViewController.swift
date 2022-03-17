import UIKit

final class BestTracksViewController: SearchViewController<BestTracksView, ArtistTracksView> {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func performRequest(onCompletion: @escaping () -> Void) {
        guard let bestTracksView = self.view as? BestTracksView else { return }
        guard let artistTracksView = bestTracksView.responseView as? ArtistTracksView else { return }
        networkManager?.getTopTracks(of: self.artistName, topTracksFetchedCompletionHandler: { tracks in

            guard let tracks = tracks else {
                DispatchQueue.main.async {
                    onCompletion()
                    let alert = UIAlertController(title: "Artist not found", message: "", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
                return
            }

            DispatchQueue.main.async {
                onCompletion()
                artistTracksView.updateView(firstTrack: tracks[0], secondTrack: tracks[1], thirdTrack: tracks[2])
                artistTracksView.isHidden = false
            }
            for index in 0 ... 2 {
                guard let url = URL(string: tracks[index].image[3].url) else { return }
                self.networkManager?.downloadImage(from: url, completion: { image in
                    DispatchQueue.main.async {
                        switch index {
                        case 0:
                            artistTracksView.firstTrack.imageView.image = image
                        case 1:
                            artistTracksView.secondTrack.imageView.image = image
                        case 2:
                            artistTracksView.thirdTrack.imageView.image = image
                        default:
                            break
                        }
                    }
                })
            }
        })
    }
}
