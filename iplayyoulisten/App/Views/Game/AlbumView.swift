//
//  AlbumView.swift
//  iplayyoulisten
//
//  Created by Jed Kutai on 6/19/24.
//

import SwiftUI

struct AlbumView: View {
    let puzzle: PuzzleModel
    let album: AlbumModel
    let albums: [AlbumModel]
    
    @State private var guessText: String = ""
    @State private var guessState: GuessState = .none
    @State private var showGiveUpAlert: Bool = false
    @State private var showHowToPlaySheet: Bool = false
    @State private var successHapticTrigger: Bool = false
    @State private var errorHapticTrigger: Bool = false
    @FocusState private var keyboardFocused: Bool
    
    
    let screenWidth: CGFloat = UIScreen.main.bounds.width
    
    
    @Binding var currentIndex: Int
    @Binding var scoreCard: [String: Bool]
    var body: some View {
        if #available(iOS 17.0, *) {
            ZStack {
                
                MenuBackground()
                
                VStack {
                    DisplayAlbumGenreAndYear(genre: album.genre, year: album.releaseYear)
                    
                    DisplayArtwork(artworkUrl: album.artworkUrl)
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
                        PuzzleHint(artistName: album.artist)
                        
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
            .sheet(isPresented: $showHowToPlaySheet) {
                HowToPlayView()
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        showHowToPlaySheet.toggle()
                    } label: {
                        Image(systemName: "questionmark.circle")
                            .foregroundStyle(.black)
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
                Button("Give Up", role: .destructive) { guessState = .giveUp }
                Button("Keep Trying", role: .cancel) { showGiveUpAlert = false }
            } message: {
                Text("Giving up will show you the solution.")
            }
            .sensoryFeedback(.success, trigger: successHapticTrigger)
            .sensoryFeedback(.error, trigger: errorHapticTrigger)
        } else {
            // Fallback on earlier versions
            ZStack {
                
                MenuBackground()
                
                VStack {
                    DisplayAlbumGenreAndYear(genre: album.genre, year: album.releaseYear)
                    
                    DisplayArtwork(artworkUrl: album.artworkUrl)
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
                        PuzzleHint(artistName: album.artist)
                        
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
            .sheet(isPresented: $showHowToPlaySheet) {
                HowToPlayView()
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        showHowToPlaySheet.toggle()
                    } label: {
                        Image(systemName: "questionmark.circle")
                            .foregroundStyle(.black)
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
                Button("Give Up", role: .destructive) { guessState = .giveUp }
                Button("Keep Trying", role: .cancel) { showGiveUpAlert = false }
            } message: {
                Text("Giving up will show you the solution.")
            }
        }

    }
    
    private func checkAnswer() {
        let submission = guessText.lowercased()
        
        if submission == album.artist.lowercased() {
            scoreCard[album.id] = true
            
            successHapticTrigger.toggle()
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
//    AlbumView()
//}
