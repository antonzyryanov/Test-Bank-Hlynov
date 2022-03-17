import Foundation

struct ResponseWithTopTracks: Decodable {
    var topTracks: Toptracks
    enum CodingKeys: String, CodingKey {
        case topTracks = "toptracks"
    }
}

struct Toptracks: Decodable {
    var track: [Track]

    enum CodingKeys: String, CodingKey {
        case track
    }
}

struct Track: Decodable {
    var name: String
    let image: [TrackImage]

    enum CodingKeys: String, CodingKey {
        case name, image
    }
}

struct TrackImage: Decodable {
    var url: String
    var size: String

    enum CodingKeys: String, CodingKey {
        case size
        case url = "#text"
    }
}
