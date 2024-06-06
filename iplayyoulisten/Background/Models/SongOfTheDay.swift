//
//  SongOfTheDay.swift
//  iplayyoulisten
//
//  Created by Jed Kutai on 6/5/24.
//

import Foundation

struct SongOfTheDay: Identifiable, Codable, Hashable {
    let id: Int
    
    var album: String?
    var appleMusicLink: String?
    var artist: String?
    var artwork: String?
    var details: String?
    var explicit: Bool?
    var genre: String?
    var releaseYear: Int?
    var spotifyLink: String?
    var title: String?
}

extension SongOfTheDay {
    static var song: SongOfTheDay = .init(
        id: 1,
        album: "Summer's Gone",
        appleMusicLink: "https://music.apple.com/us/album/iplayyoulisten/1140187592?i=1140188108",
        artist: "ODESZA",
        artwork: "https://firebasestorage.googleapis.com/v0/b/iplayyoulisten.appspot.com/o/admin%2Fartwork%2FODESZA%2Fsummersgone.jpeg?alt=media&token=fa3d0963-0991-4feb-a55d-db630e0f89df",
        details: "\"IPlayYouListen\" is a mesmerizing track by ODESZA, a Seattle-based electronic music duo known for their innovative blend of dreamy synths, intricate beats, and emotive melodies. This song is a standout piece from their debut album, Summer's Gone, which captures the essence of nostalgic summers with its lush soundscapes and evocative rhythms. \"IPlayYouListen\" exemplifies ODESZA's ability to create immersive auditory experiences, making it a favorite among fans for its hypnotic progression and ethereal atmosphere. Whether you're relaxing or seeking inspiration, this track is sure to transport you to a world of sonic bliss.",
        explicit: false,
        genre: "Electronic",
        releaseYear: 2012,
        spotifyLink: "https://open.spotify.com/track/3xhR3mClWXydDCByJxnOwY?si=9587bd9b5d5a48c2",
        title: "IPlayYouListen"
    )
}
