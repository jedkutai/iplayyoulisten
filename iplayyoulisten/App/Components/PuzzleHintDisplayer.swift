//
//  PuzzleHintDisplayer.swift
//  iplayyoulisten
//
//  Created by Jed Kutai on 6/23/24.
//

import SwiftUI

struct PuzzleHintDisplayer: View {
    let artistName: String
    let hiddenIndexes: [Int]
    let guessedLetters: [String]
    
    var body: some View {
        Text(HintFunctions.hintDisplayText(artistName: artistName, hiddenIndexes: hiddenIndexes, guessedLetters: guessedLetters))
            .frame(height: 40)
            .font(.title.weight(.bold))
            .foregroundStyle(.black)
            .lineLimit(1)
            .minimumScaleFactor(0.1)
    }
    
}

#Preview {
    PuzzleHintDisplayer(artistName: "Big K.R.I.T.", hiddenIndexes: [0, 2, 6], guessedLetters: ["b", "g", "r"])
}
