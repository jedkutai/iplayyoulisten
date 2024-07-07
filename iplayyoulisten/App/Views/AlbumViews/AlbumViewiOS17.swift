//
//  AlbumViewiOS17.swift
//  iplayyoulisten
//
//  Created by Jed Kutai on 6/21/24.
//

import SwiftUI

@available(iOS 17.0, *)
struct AlbumViewiOS17: View {
    let puzzle: PuzzleModel
    let album: AlbumModel
    let albums: [AlbumModel]
    
    @Binding var currentIndex: Int
    @Binding var scoreCard: [String: Bool]
    
    @State var hiddenIndexes: [Int]
    
    @State private var guessedLetters: [String] = []
//    @State private var guessText: String = ""
    @State private var guessState: GuessState = .none
    @State private var showGiveUpAlert: Bool = false
    @State private var successHapticTrigger: Bool = false
    @State private var errorHapticTrigger: Bool = false
    @State private var unblur: Bool = false
    @State private var showKeyboard: Bool = false
    
    
    let screenWidth: CGFloat = UIScreen.main.bounds.width
    
    
    @EnvironmentObject var x: X
    
    var body: some View {
        ZStack {
            
            MenuBackground()
            
            VStack {
                DisplayAlbumGenreAndYear(genre: album.genre, year: album.releaseYear)
                
                DisplayArtwork2(artworkUrl: album.artworkUrl, artworkUnblurredUrl: album.artworkUnblurredUrl, showUnblurred: unblur)
                    .shadow(radius: 5)
                
                DisplayAlbumTitle(title: album.title)
                
                Spacer()
                
                
                AlbumViewiOS17Bottom(guessState: $guessState, showKeyboard: $showKeyboard, guessedLetters: $guessedLetters, successHapticTrigger: $successHapticTrigger, errorHapticTrigger: $errorHapticTrigger, unblur: $unblur, scoreCard: $scoreCard, album: album, hiddenIndexes: hiddenIndexes)
            }
            .padding()
        }
        .onAppear {
            scoreCard[album.id] = false
        }
        .onChange(of: guessedLetters) {
            guessState = .none
        }
        .toolbar {
            if guessedLetters.isEmpty {
                let hiddenIndexesCount = hiddenIndexes.count
                
                if hiddenIndexesCount > 2 && x.hintsRemaining > 0 {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            // use hint
                            x.updateHintsRemaining(change: -1)
                            hiddenIndexes.remove(at: Int.random(in: 0..<hiddenIndexesCount))
                        } label: {
                            Text("Hints: \(x.hintsRemaining)")
                                .foregroundStyle(.black)
                                .minimumScaleFactor(0.1)
                        }
                    }
                }
            }
            
            if self.showNext() {
                if currentIndex < albums.count - 1 {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            withAnimation {
                                currentIndex += 1
                            }
                        } label: {
                            Text("Next")
                                .foregroundStyle(.black)
                        }
                    }
                } else {
                    ToolbarItem(placement: .topBarTrailing) {
                        NavigationLink {
                            ResultsView(puzzle: puzzle, albums: albums, scoreCard: scoreCard).navigationBarBackButtonHidden()
                        } label: {
                            Text("Results") // change to skip
                                .foregroundStyle(.black)
                        }
                    }
                }
            } else {
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
        .alert("Give Up?", isPresented: $showGiveUpAlert) {
            Button("Give Up", role: .destructive) {
                guessState = .giveUp
                unblur = true
            }
            Button("Keep Trying", role: .cancel) { showGiveUpAlert = false }
        } message: {
            Text("Giving up will show you the solution.")
        }
        .sensoryFeedback(.success, trigger: successHapticTrigger)
        .sensoryFeedback(.error, trigger: errorHapticTrigger)
        .sensoryFeedback(.decrease, trigger: hiddenIndexes)
        .sensoryFeedback(.increase, trigger: guessedLetters)
    }
    
    private func showNext() -> Bool {
        return guessState == .giveUp || guessState == .correct
    }
    
    
}

//#Preview {
//    AlbumViewiOS17()
//}
