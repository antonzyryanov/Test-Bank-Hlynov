class ArtistNameFormatter {
    func formatName(of artist: String) -> String {
        var artist = artist
        while artist.last == " " {
            artist.removeLast()
        }
        while artist.first == " " {
            artist.removeFirst()
        }
        artist = artist.URLEncoded
        return artist
    }
}
