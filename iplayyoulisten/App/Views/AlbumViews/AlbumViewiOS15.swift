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
    
    @State var hiddenIndexes: [Int]
    
    @State private var guessText: String = ""
    @State private var guessState: GuessState = .none
    @State private var showGiveUpAlert: Bool = false
    @State private var successHapticTrigger: Bool = false
    @State private var errorHapticTrigger: Bool = false
    @State private var unblur: Bool = false
    
    @FocusState private var keyboardFocused: Bool
    
    
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
                
                
                if guessState == .correct {
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 15)
                            .foregroundStyle(Color(.systemGreen))
                        
                        DisplayArtist(artistName: album.artist)
                        
                        
                    }
                } else if guessState == .giveUp {
                    HStack {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 15)
                            .foregroundStyle(Color(.systemRed))
                        
                        DisplayArtist(artistName: album.artist)
                        
                    }
                } else {
                    PuzzleHintDisplayer(artistName: album.artist, hiddenIndexes: hiddenIndexes, guessedLetters: [])
                    
                    if guessState == .incorrect {
                        Text("Incorrect")
                            .font(.subheadline)
                            .foregroundStyle(Color(.systemRed))
                            .lineLimit(1)
                            .minimumScaleFactor(0.1)
                    }
                    
                    HStack {
                        HStack {
                            TextField("Artist Name", text: $guessText)
                                .focused($keyboardFocused)
                                .autocorrectionDisabled()
                            
                            if keyboardFocused {
                                Button {
                                    keyboardFocused = false
                                } label: {
                                    Image(systemName: "keyboard.chevron.compact.down")
                                        .foregroundStyle(.black)
                                }
                            }
                            
                            
                        }
                        .padding(10)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(.white)
                                
                        )
                        
                        if !guessText.isEmpty {
                            Button {
                                checkAnswer()
                            } label: {
                                Image(systemName: "arrow.up.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30)
                                    .foregroundColor(Color(.systemBlue))
                            }
                        }
                    }
                }
            }
            .padding()
        }
        .onAppear {
            scoreCard[album.id] = false
        }
        .onSubmit {
            checkAnswer()
        }
        .onChange(of: keyboardFocused) { _ in
            if keyboardFocused {
                guessState = .none
            }
        }
        .toolbar {
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
            
            if guessState == .giveUp || guessState == .correct {
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
    }
    
    private func checkAnswer() {
        let submission = guessText.lowercased()
        
        if submission == album.artist.lowercased() {
            scoreCard[album.id] = true
            
            successHapticTrigger.toggle()
            unblur = true
            withAnimation {
                guessState = .correct
            }
        } else {
            errorHapticTrigger.toggle()
            withAnimation {
                guessState = .incorrect
            }
        }
        
        guessText = ""
    }
}

//#Preview {
//    AlbumViewiOS15()
//}
