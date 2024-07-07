//
//  AlbumViewController.swift
//  iplayyoulisten
//
//  Created by Jed Kutai on 6/21/24.
//

import SwiftUI

struct AlbumViewController: View {
    let puzzle: PuzzleModel
    let album: AlbumModel
    let albums: [AlbumModel]
    
    @Binding var currentIndex: Int
    @Binding var scoreCard: [String: Bool]
    
    @State private var guessText: String = ""
    @State private var guessState: GuessState = .none
    @State private var showGiveUpAlert: Bool = false
    @State private var showHowToPlaySheet: Bool = false
    @State private var successHapticTrigger: Bool = false
    @State private var errorHapticTrigger: Bool = false
    
    @FocusState private var keyboardFocused: Bool
    
    let screenWidth: CGFloat = UIScreen.main.bounds.width
    
    
    
    var body: some View {
        if #available(iOS 17.0, *) {
            AlbumViewiOS17(puzzle: puzzle, album: album, albums: albums, currentIndex: $currentIndex, scoreCard: $scoreCard, hiddenIndexes: HintFunctions.getHiddenIndexes(artistName: album.artist))
        } else {
            AlbumViewiOS15(puzzle: puzzle, album: album, albums: albums, currentIndex: $currentIndex, scoreCard: $scoreCard, hiddenIndexes: HintFunctions.getHiddenIndexes(artistName: album.artist))
        }
    }
}

//#Preview {
//    AlbumViewController()
//}
