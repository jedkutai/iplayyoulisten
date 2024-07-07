//
//  AlbumViewiOS17Bottom.swift
//  iplayyoulisten
//
//  Created by Jed Kutai on 6/24/24.
//

import SwiftUI

struct AlbumViewiOS17Bottom: View {
    @Binding var guessState: GuessState
    @Binding var showKeyboard: Bool
    @Binding var guessedLetters: [String]
    @Binding var successHapticTrigger: Bool
    @Binding var errorHapticTrigger: Bool
    @Binding var unblur: Bool
    @Binding var scoreCard: [String: Bool]
    
    let album: AlbumModel
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
                    
                    Button {
                        withAnimation {
                            showKeyboard.toggle()
                        }
                    } label: {
                        PuzzleHintDisplayer(artistName: album.artist, hiddenIndexes: hiddenIndexes, guessedLetters: guessedLetters)
                    }
                    
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
        successHapticTrigger.toggle()
        
        scoreCard[album.id] = true
        unblur = true
        withAnimation {
            showKeyboard = false
            guessState = .correct
        }
    }
    
    private func wrongAnswer() {
        errorHapticTrigger.toggle()
        withAnimation {
            guessState = .incorrect
        }
    }
}

//#Preview {
//    AlbumViewiOS17Bottom()
//}
