//
//  FetchService.swift
//  iplayyoulisten
//
//  Created by Jed Kutai on 6/5/24.
//

import Foundation
import Firebase
import FirebaseFirestore

struct FetchService {
    static func fetchSongOfTheDay() async throws -> SongOfTheDay? {
        var songOfTheDay: SongOfTheDay?
        
        let snapshot = try await Firestore.firestore().collection("songs")
            .order(by: "id", descending: true)
            .limit(to: 1)
            .getDocuments()
        
        let songs = snapshot.documents.compactMap({ try? $0.data(as: SongOfTheDay.self) })
        
        if let firstSong = songs.first {
            songOfTheDay = firstSong
        }
        
        return songOfTheDay
    }
}
