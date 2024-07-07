//
//  AlbumViewiOS15.swift
//  iplayyoulisten
//
//  Created by Jed Kutai on 6/21/24.
//

import SwiftUI

struct AlbumViewiOS15: View {
    let puzzle: PuzzleModel
    let album: AlbumModel
    let albums: [AlbumModel]
    
    @Binding var currentIndex: Int
    @Binding var scoreCard: [String: Bool]
    @Binding var hintsUsed: Int
    
    @State var hiddenIndexes: [Int]
    
    @State private var guessedLetters: [String] = []
    @State private var guessState: GuessState = .none
    @State private var showGiveUpAlert: Bool = false
    @State private var unblur: Bool = false
    @State private var showKeyboard: Bool = true
    
    
    
    let screenWidth: CGFloat = UIScreen.main.bounds.width
    
    @EnvironmentObject var x: X
    
    
    var body: some View {
        ZStack {
            
            AppBackground()
            
            VStack {
                DisplayAlbumGenreAndYear(genre: album.genre, year: album.releaseYear)
                
                DisplayArtwork2(artworkUrl: album.artworkUrl, artworkUnblurredUrl: album.artworkUnblurredUrl, showUnblurred: unblur)
                    .shadow(radius: 5)
        
                DisplayAlbumTitle(title: album.title)
                
                Spacer()
                
                
                AlbumViewiOS15Bottom(guessState: $guessState, showKeyboard: $showKeyboard, guessedLetters: $guessedLetters, unblur: $unblur, scoreCard: $scoreCard, currentIndex: $currentIndex, hintsUsed: $hintsUsed, puzzle: puzzle, album: album, albums: albums, hiddenIndexes: hiddenIndexes)
                
            }
            .padding()
        }
        .onAppear {
            scoreCard[album.id] = false
        }
        .toolbar {
            if guessState != .giveUp || guessState != .correct {
                if guessedLetters.isEmpty {
                    let hiddenIndexesCount = hiddenIndexes.count
                    
                    if hiddenIndexesCount > 2 && x.hintsRemaining > 0 {
                        ToolbarItem(placement: .topBarLeading) {
                            Button {
                                // use hint
                                x.updateHintsRemaining(change: -1)
                                hintsUsed += 1
                                hiddenIndexes.remove(at: Int.random(in: 0..<hiddenIndexesCount))
                            } label: {
                                Text("Hints: \(x.hintsRemaining)")
                                    .foregroundStyle(.black)
                                    .minimumScaleFactor(0.1)
                            }
                        }
                    }
                }
                
                if guessState != .giveUp && guessState != .correct {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            showGiveUpAlert = true
                        } label: {
                            Text("Give Up")
                                .foregroundStyle(.black)
                        }
                    }
                }
                
            }
            
            
            if let previewId = album.previewId {
                ToolbarItem(placement: .topBarTrailing) {
                    MusicHintPlayer(previewId: previewId)
                }
            }
            
            
        }
        .alert("Give Up?", isPresented: $showGiveUpAlert) {
            Button("Give Up", role: .destructive) {
                guessState = .giveUp
                unblur = true
            }
            Button("Keep Trying", role: .cancel) { showGiveUpAlert = false }
        } message: {
            Text("Giving up will show you the solution.")
        }
    }
    
}

//#Preview {
//    AlbumViewiOS15()
//}
