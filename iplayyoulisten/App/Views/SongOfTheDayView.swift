//
//  SongOfTheDayView.swift
//  iplayyoulisten
//
//  Created by Jed Kutai on 6/5/24.
//

import SwiftUI

struct SongOfTheDayView: View {
    @State private var songOfTheDay: SongOfTheDay?
    @State private var failed = false
    
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        NavigationStack {
            VStack {
                if let songOfTheDay = self.songOfTheDay {
                    DisplaySongCell(songOfTheDay: songOfTheDay)
                } else if failed {
                    Button {
                        // reload page
                        self.onAppearActions()
                    } label: {
                        Image(systemName: "arrow.circlepath")
                            .foregroundStyle(colorScheme == .dark ? .white : .black)
                    }
                } else {
                    ProgressView()
                }
            }
            .toolbar {
                NavigationLink {
                    // history
                    HistoryView()
                } label: {
                    Image(systemName: "clock.arrow.circlepath")
                        .foregroundStyle(colorScheme == .dark ? .white : .black)
                }
            }
            .onAppear {
                self.onAppearActions()
            }
        }
    }
    
    private func onAppearActions() {
        // fetch the song of the day
        failed = false
        Task {
            do {
                
                self.songOfTheDay = try await FetchService.fetchSongOfTheDay()
            } catch {
                print("Can't load song of day: \(error.localizedDescription)")
                failed = true
            }
        }
    }
}

#Preview {
    SongOfTheDayView()
}
