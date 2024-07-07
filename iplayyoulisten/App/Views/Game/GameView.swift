//
//  GameView.swift
//  iplayyoulisten
//
//  Created by Jed Kutai on 6/19/24.
//

import SwiftUI
import Kingfisher

enum GuessState {
    case none
    case close
    case incorrect
    case correct
    case giveUp
}

struct GameView: View {
    let puzzle: PuzzleModel
    let albums: [AlbumModel]
    
    @State private var currentIndex: Int = 0
    @State private var scoreCard = [String: Bool]()
    @State private var hintsUsed = 0
    
    var body: some View {
        NavigationStack {
            ZStack {
                ForEach(Array(albums.enumerated()), id: \.0) { index, album in
                    if currentIndex == index {
                        AlbumViewController(puzzle: puzzle, album: album, albums: albums, currentIndex: $currentIndex, scoreCard: $scoreCard, hintsUsed: $hintsUsed)
                    }
                }
            }
        }
    }
}



//#Preview {
//    GameView(puzzle: PuzzleModel.puzzle, albums: AlbumModel.albums)
//}
