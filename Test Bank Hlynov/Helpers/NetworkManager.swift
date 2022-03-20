import Foundation
import UIKit

struct API {
    static let rootURL = "https://ws.audioscrobbler.com/2.0/"
    static let apiKey = "0c5f15cbf2be8cd8c1f396aa40bd20ac"
}

enum APIRequestsMethods {
    static let getArtistInfo = "method=artist.getinfo"
    static let getTopTrack = "method=artist.gettoptracks"
}

class NetworkManager {
    
    let artistNameFormatter = ArtistNameFormatter()
    
    func getData(with url: URL, completion: @escaping (Data?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                completion(nil)
                return
            }
            guard let data = data else {
                completion(nil)
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                completion(nil)
                return
            }
            completion(data)
        }.resume()
    }

    func getInfo(about artist: String, artistInfoFetchedCompletionHandler: @escaping (Artist?) -> Void) {
        let artistName = artistNameFormatter.formatName(of: artist)
        let urlString = API.rootURL + "?" + APIRequestsMethods.getArtistInfo
            + "&artist=" + artistName + "&api_key=" + API.apiKey + "&format=json" + "&lang=ru" + "&autocorrect=1"
        guard let url = URL(string: urlString) else {
            artistInfoFetchedCompletionHandler(nil)
            return
        }
        self.getData(with: url) { [self] data in
            guard let data = data else {
                artistInfoFetchedCompletionHandler(nil)
                return
            }
            parseArtist(from: data, artistInfoFetchedCompletionHandler: artistInfoFetchedCompletionHandler)
        }
    }

    func parseArtist(from json: Data, artistInfoFetchedCompletionHandler: ((Artist?) -> Void)?) {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let response = try decoder.decode(ResponseWithArtistInfo.self, from: json)
            guard let completion = artistInfoFetchedCompletionHandler else { return }
            completion(response.artist)
        } catch {
            guard let completion = artistInfoFetchedCompletionHandler else { return }
            completion(nil)
        }
    }

    private func getImageData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }

    func getTopTracks(of artist: String, topTracksFetchedCompletionHandler: @escaping ([Track]?) -> Void) {
        let artistName = artistNameFormatter.formatName(of: artist)
        let urlString = API.rootURL + "?" + APIRequestsMethods.getTopTrack
            + "&artist=" + artistName + "&api_key=" + API.apiKey + "&format=json" + "&autocorrect=1"
        guard let url = URL(string: urlString) else { return }
        self.getData(with: url) { [self] data in
            guard let data = data else {
                topTracksFetchedCompletionHandler(nil)
                return
            }
            parseTopTracks(from: data, topTracksFetchedCompletionHandler: topTracksFetchedCompletionHandler)
        }
    }

    func parseTopTracks(from json: Data, topTracksFetchedCompletionHandler: (([Track]?) -> Void)?) {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let response = try decoder.decode(ResponseWithTopTracks.self, from: json)
            guard let completion = topTracksFetchedCompletionHandler else { return }
            let tracks = response.topTracks.track
            completion(tracks)
        } catch {
            guard let completion = topTracksFetchedCompletionHandler else { return }
            completion(nil)
            print("Parsing failed")
        }
    }

    func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        self.getImageData(from: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            guard let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            completion(image)
        }
    }
}
