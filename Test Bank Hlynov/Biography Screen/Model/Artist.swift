struct ResponseWithArtistInfo: Decodable {
    var artist: Artist
    enum CodingKeys: String, CodingKey {
        case artist
    }
}

struct Artist: Decodable {
    var name: String
    var image: [ArtistImage]
    var biography: Biography
    enum CodingKeys: String, CodingKey {
        case name
        case image
        case biography = "bio"
    }
}

struct Biography: Decodable {
    var summary: String
    enum CodingKeys: String, CodingKey {
        case summary
    }
}

struct ArtistImage: Decodable {
    var size: String
    var url: String
    enum CodingKeys: String, CodingKey {
        case size
        case url = "#text"
    }
}
