//
//  AlbumViewiOS15Bottom.swift
//  iplayyoulisten
//
//  Created by Jed Kutai on 6/24/24.
//

import SwiftUI

struct AlbumViewiOS15Bottom: View {
    @Binding var guessState: GuessState
    @Binding var showKeyboard: Bool
    @Binding var guessedLetters: [String]
    @Binding var unblur: Bool
    @Binding var scoreCard: [String: Bool]
    @Binding var currentIndex: Int
    @Binding var hintsUsed: Int
    
    let puzzle: PuzzleModel
    let album: AlbumModel
    let albums: [AlbumModel]
    let hiddenIndexes: [Int]
    
    var body: some View {
        VStack {
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
                HStack {
                    
                    Spacer()
                    
                    if guessState == .incorrect {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 15)
                            .foregroundStyle(Color(.systemRed))
                    } else {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 15)
                            .foregroundStyle(Color(.clear))
                    }
                    
//                    Button {
//                        withAnimation {
//                            showKeyboard.toggle()
//                        }
//                    } label: {
//                        PuzzleHintDisplayer(artistName: album.artist, hiddenIndexes: hiddenIndexes, guessedLetters: guessedLetters)
//                    }
                    PuzzleHintDisplayer(artistName: album.artist, hiddenIndexes: hiddenIndexes, guessedLetters: guessedLetters)
                    
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 15)
                        .foregroundStyle(Color(.clear))
                    
                    Spacer()
                    
                }
                
                if showKeyboard {
                    CustomKeyboard(letters: $guessedLetters, hiddenIndexes: hiddenIndexes)
                    
                    if guessedLetters.isEmpty {
                        Text("Submit")
                            .foregroundStyle(.black)
                            .font(.subheadline)
                            .frame(maxWidth: .infinity)
                            .padding(5)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundStyle(.ultraThinMaterial)
                            )
                    } else {
                        Button {
                            if checkAnswer() {
                                correctAnswer()
                            } else {
                                wrongAnswer()
                            }
                        } label: {
                            Text("Submit")
                                .foregroundStyle(.white)
                                .font(.subheadline)
                                .frame(maxWidth: .infinity)
                                .padding(5)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundStyle(Color(.systemBlue))
                                )
                                
                        }
                    }
                }
                
            }
            
            if guessState == .giveUp || guessState == .correct {
                if currentIndex < albums.count - 1 {
                    Button {
                        withAnimation {
                            currentIndex += 1
                        }
                    } label: {
//                        Text("Next")
//                            .foregroundStyle(.black)
                        FlatLabel(text: "Next")
                    }
                } else {
                    NavigationLink {
                        ResultsView(puzzle: puzzle, albums: albums, scoreCard: scoreCard, hintsUsed: hintsUsed).navigationBarBackButtonHidden()
                    } label: {
//                        Text("Results") // change to skip
//                            .foregroundStyle(.black)
                        FlatLabel(text: "Results")
                    }
                }
            }
        }
    }
    
    private func checkAnswer() -> Bool {
        var hiddenLetters: String = ""
        var guessString: String = ""
        
        for (dex, char) in album.artist.enumerated() {
            if hiddenIndexes.contains(dex) {
                hiddenLetters += String(char)
            }
        }
        
        for char in guessedLetters {
            guessString += char
        }
        
        return hiddenLetters.lowercased() == guessString.lowercased()
    }
    

    private func correctAnswer() {
        
        scoreCard[album.id] = true
        unblur = true
        withAnimation {
            showKeyboard = false
            guessState = .correct
        }
    }
    
    private func wrongAnswer() {
        withAnimation {
            guessState = .incorrect
        }
    }
}

//#Preview {
//    AlbumViewiOS15Bottom()
//}
