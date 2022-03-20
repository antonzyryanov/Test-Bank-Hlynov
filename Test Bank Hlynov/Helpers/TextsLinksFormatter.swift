class TextsLinksFormatter {
    func formatLinksInBiography(of artist: Artist) -> Artist {
        var artist = artist
        if var lastFMArtistLink = artist.biography.summary.slice(from: "<a href=", to: "\">Read") {
            lastFMArtistLink.removeFirst()
            let stringToReplace = "<a href=\"" + lastFMArtistLink + "\">Read more on Last.fm</a>"
            artist.biography.summary = artist.biography.summary.replacingOccurrences(of: stringToReplace, with: lastFMArtistLink)
            return artist
        } else {
            return artist
        }
    }
}
