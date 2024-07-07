//
//  ResultsView.swift
//  iplayyoulisten
//
//  Created by Jed Kutai on 6/20/24.
//

import SwiftUI

struct ResultsView: View {
    let puzzle: PuzzleModel
    let albums: [AlbumModel]
    let scoreCard: [String: Bool]
    let hintsUsed: Int
    
    var hideMenuButton: Any?
    
    @EnvironmentObject var x: X
    
    let iconDimension: CGFloat = UIScreen.main.bounds.width * 0.25
    
    var body: some View {
        NavigationStack {
            ZStack {
                AppBackground()
                
                VStack {
                    Image(systemName: "plus")
                        .resizable()
                        .scaledToFit()
                        .frame(width: iconDimension, height: iconDimension)
                        .foregroundStyle(.thinMaterial)
                    
                    Spacer()
                    
                    ForEach(albums, id: \.id) { album in
                        if let correct = scoreCard[album.id] {
                            HStack {
                                if correct {
                                    Image(systemName: "checkmark.circle.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 15)
                                        .foregroundStyle(Color(.systemGreen))
                                    
                                } else {
                                    Image(systemName: "xmark.circle.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 15)
                                        .foregroundStyle(Color(.systemRed))
                                }
                                
                                ResultCell(album: album, correct: correct)
                            }
                            .padding(.top)
                            
                        }
                    }
                    
                    Spacer()
                    
                    Text(puzzle.startTime.dateValue().formatted(date: .abbreviated, time: .omitted))
                        .font(.title.weight(.semibold))
                        .foregroundStyle(.black)
                        .lineLimit(1)
                        .minimumScaleFactor(0.1)
                    
                    Spacer()
                    
                    Text("Hints Used: \(hintsUsed)")
                        .font(.footnote)
                        .foregroundStyle(.black)
                }
                .padding()
            }
            .toolbar {
                
                if hideMenuButton == nil {
                    ToolbarItem(placement: .topBarLeading) {
                        NavigationLink {
                            MainMenuView(puzzle: puzzle, albums: albums, scoreCard: scoreCard, hintsUsed: hintsUsed).navigationBarBackButtonHidden()
                        } label: {
                            Text("Menu")
                                .foregroundStyle(.black)
                        }
                    }
                }
                
                if x.twoOrMoreCorrect > 0 {
                    ToolbarItem(placement: .topBarTrailing) {
                        StreaksDisplay()
                    }
                }
            }
            .onAppear {
                if hideMenuButton == nil {
                    x.updateStreaks(scoreBoard: scoreCard)
                }
            }
        }
    }
    
    
}


//#Preview {
//    ResultsView(puzzle: PuzzleModel.puzzle, albums: AlbumModel.albums, scoreCard: AlbumModel.scoreCard, hintsUsed: 5)
//}
