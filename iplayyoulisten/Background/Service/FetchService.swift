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
    static func fetchTodaysPuzzle() async throws -> PuzzleModel? {
        var puzzle: PuzzleModel?
        
        let currentTimestamp = Date.now
        
        let snapshot = try await Firestore.firestore().collection("puzzles")
            .whereField("startTime", isLessThanOrEqualTo: currentTimestamp)
            .whereField("endTime", isGreaterThan: currentTimestamp)
            .limit(to: 1)
            .getDocuments()
        
        let puzzles = snapshot.documents.compactMap({ try? $0.data(as: PuzzleModel.self) })
        
        if let firstPuzzle = puzzles.first {
            puzzle = firstPuzzle
        }
        
        return puzzle
    }
    
    static func fetchPuzzlesHistory(limit: Int) async throws -> [PuzzleModel] {
        var puzzles: [PuzzleModel] = []
        
        let currentTimestamp = Date.now
        
        let snapshot = try await Firestore.firestore().collection("puzzles")
            .whereField("endTime", isLessThan: currentTimestamp)
            .order(by: "endTime", descending: true)
            .limit(to: limit)
            .getDocuments()
        
        let fetchedPuzzles = snapshot.documents.compactMap({ try? $0.data(as: PuzzleModel.self) })
        puzzles = fetchedPuzzles
        
        return puzzles
    }
    
    static func fetchPuzzleById(id: String) async throws -> PuzzleModel {
        let snapshot = try await Firestore.firestore().collection("puzzles").document(id).getDocument()
        return try snapshot.data(as: PuzzleModel.self)
    }
    
    
    static func fetchAlbumById(id: String) async throws -> AlbumModel {
        let snapshot = try await Firestore.firestore().collection("albums").document(id).getDocument()
        return try snapshot.data(as: AlbumModel.self)
    }
    
    static func fetchAlbumsByPuzzle(puzzle: PuzzleModel) async throws -> [AlbumModel] {
        var albums: [AlbumModel] = []
        
        for id in puzzle.albumIds {
            
            let fetchedAlbum = try await self.fetchAlbumById(id: id)
            albums.append(fetchedAlbum)
        }
        
        return albums
    }
}
