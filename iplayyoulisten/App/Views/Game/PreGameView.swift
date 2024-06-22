//
//  PreGameView.swift
//  iplayyoulisten
//
//  Created by Jed Kutai on 6/18/24.
//

import SwiftUI

struct PreGameView: View {
    @State private var puzzle: PuzzleModel?
    @State private var failed: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                MenuBackground()
                
                VStack {
                    if let puzzle = self.puzzle {
                        PreGameLoadedView(puzzle: puzzle)
                    } else if failed {
                        Button {
                            self.onAppearActions()
                        } label: {
                            Text("Spin the block")
                        }
                    } else {
                        ProgressView()
                    }
                }
                .padding()
            }
            .onAppear {
                self.onAppearActions()
            }
        }
    }
    
    
    private func onAppearActions() {
        self.failed = false
        Task {
            do {
                self.puzzle = try await FetchService.fetchTodaysPuzzle()
                if self.puzzle == nil {
                    failed = true
                }
            } catch {
                self.failed = true
            }
        }
    }
}

private struct PreGameLoadedView: View {
    let puzzle: PuzzleModel
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var x: X
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                if x.lastPuzzlePlayedId == puzzle.id {
                    
                    Text("Next Puzzle At:")
                        .font(.title.weight(.semibold))
                        .foregroundStyle(colorScheme == .dark ? .white : .black)
                        .minimumScaleFactor(0.1)
                    
                    
                    Text(puzzle.endTime.dateValue().formatted(date: .abbreviated, time: .shortened))
                        .font(.title.weight(.semibold))
                        .foregroundStyle(Color(.systemGray))
                        .minimumScaleFactor(0.1)
                    
                } else {
                    NavigationLink {
                        
                    } label: {
                        Text("Start")
                            .font(.title.weight(.semibold))
                            .foregroundStyle(colorScheme == .dark ? .white : .black)
                            .minimumScaleFactor(0.1)
                    }
                    
                    Text("Once you start today's puzzle, you can't replay it.")
                        .font(.subheadline)
                        .foregroundStyle(Color(.systemRed))
                        .multilineTextAlignment(.center)
                    
//                    ForEach(puzzle.albumIds, id: \.self) { id in
//                        Text(id)
//                    }
                }
            }
        }
    }
}

//#Preview {
//    PreGameView()
//}
