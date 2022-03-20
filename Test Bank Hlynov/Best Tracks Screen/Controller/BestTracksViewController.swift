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
                self.presentAlert(onCompletion: onCompletion)
                return
            }

            DispatchQueue.main.async {
                artistTracksView.updateView(firstTrack: tracks[0], secondTrack: tracks[1], thirdTrack: tracks[2])
                artistTracksView.isHidden = false
                onCompletion()
            }
            for index in 0 ... 2 {
                guard let url = URL(string: tracks[index].image[3].url) else {
                    return
                }
                self.networkManager?.downloadImage(from: url, completion: { image in
                    DispatchQueue.main.async {
                        if image != nil {
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
                    }
                })
            }
        })
    }
}
