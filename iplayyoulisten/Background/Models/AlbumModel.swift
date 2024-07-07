//
//  AlbumModel.swift
//  iplayyoulisten
//
//  Created by Jed Kutai on 6/18/24.
//

import Foundation
import Firebase

struct AlbumModel: Identifiable, Hashable, Codable {
    let id: String
    let artist: String
    let title: String
    let genre: String
    let releaseYear: Int
    var previewUrl: String?
    var previewId: String?
    let artworkUrl: String
    var artworkUnblurredUrl: String?
    let appleMusicLink: String
    let spotifyLink: String
}

extension AlbumModel {
    static var albums: [AlbumModel] = [
        .init(id: "sebffs2UE1pDwUc1OJCH", artist: "A$AP Ferg", title: "ALWAYS STRIVE AND PROSPER", genre: "Hip-Hop/Rap", releaseYear: 2016, artworkUrl: "https://firebasestorage.googleapis.com/v0/b/iplayyoulisten.appspot.com/o/admin%2Fartwork%2FA%24AP%20Ferg%20ALWAYS%20STRIVE%20AND%20PROS.webp?alt=media&token=b04b7840-3795-46ff-9af3-1297b7c46c0f", artworkUnblurredUrl: "https://firebasestorage.googleapis.com/v0/b/iplayyoulisten.appspot.com/o/admin%2Fartwork%2Fa%24ap%20ferg%20unblurred%20always%20strive.webp?alt=media&token=e8636b27-d8ca-4cd4-a0f6-ee411ed96124", appleMusicLink: "https://music.apple.com/us/album/always-strive-and-prosper/1126433123", spotifyLink: "https://open.spotify.com/album/2h5LDCGJCWUyaoEXQZHky6?si=xFkZCKEvQyGiTrw0zhBLEg"),
        .init(id: "WPD8D1FZNTvwiHUyp3CI", artist: "A$AP Ferg", title: "Trap Lord", genre: "Hip-Hop/Rap", releaseYear: 2013, artworkUrl: "https://firebasestorage.googleapis.com/v0/b/iplayyoulisten.appspot.com/o/admin%2Fartwork%2FA%24AP%20Ferg%20Trap%20Lord.webp?alt=media&token=fc74d888-e31e-439d-8209-7ed0770b1066", appleMusicLink: "https://music.apple.com/us/album/trap-lord/676345055", spotifyLink: "https://open.spotify.com/album/3smlfAmejcKMmAPg1G2Kki?si=VOGikUmXQnqwyPtOcT7HVw"),
        .init(id: "10j9KnGD9rPCZMJDGp9Z", artist: "A$AP Rocky", title: "AT.LONG.LAST.A$AP", genre: "Hip-Hop/Rap", releaseYear: 2015, artworkUrl: "https://firebasestorage.googleapis.com/v0/b/iplayyoulisten.appspot.com/o/admin%2Fartwork%2FA%24AP%20Rocky%20AT.LONG.LAST.A%24AP.webp?alt=media&token=979bdaa2-45bb-47ea-933e-7a14a13168fa", appleMusicLink: "https://music.apple.com/us/album/at-long-last-a%24ap/994727168", spotifyLink: "https://open.spotify.com/album/3arNdjotCvtiiLFfjKngMc?si=_WoxIRvHTYWIqn6h2DQdzw"),
        .init(id: "C1F9xKj8mBPVC9bNFr4t", artist: "A$AP Rocky", title: "LONG.LIVE.A$AP", genre: "Hip-Hop/Rap", releaseYear: 2012, artworkUrl: "https://firebasestorage.googleapis.com/v0/b/iplayyoulisten.appspot.com/o/admin%2Fartwork%2FA%24AP%20Rocky%20LONG.LIVE.A%24AP.webp?alt=media&token=143bd20f-96d6-42fc-b290-497cb680c63e", appleMusicLink: "https://music.apple.com/us/album/long-live-a%24ap-deluxe-edition/1450690198", spotifyLink: "https://open.spotify.com/album/6rzMufuu8sLkIizM4q9c7J?si=J88WmQSeT-euH8M5vfib4A")
    ]
    
    static var scoreCard: [String: Bool] = [
        "sebffs2UE1pDwUc1OJCH": false,
        "WPD8D1FZNTvwiHUyp3CI": true,
        "10j9KnGD9rPCZMJDGp9Z": false,
        "C1F9xKj8mBPVC9bNFr4t": true]
}
