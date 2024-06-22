//
//  PuzzleHint.swift
//  iplayyoulisten
//
//  Created by Jed Kutai on 6/19/24.
//

import SwiftUI

struct PuzzleHint: View {
    let artistName: String
    
    var body: some View {
        Text(self.hintDisplayText())
            .font(.title.weight(.bold))
            .foregroundStyle(.black)
            .lineLimit(1)
            .minimumScaleFactor(0.1)
    }
    
    private func hintDisplayText() ->  String {
        var hint: String = ""
        
        var empty: Bool = true
        
        let alphabet: String = "abcdefghijklmnopqrstuvwxyz"
        
        for char in artistName {
            if !empty {
                hint += " "
            }
            if alphabet.contains(char.lowercased()) {
                hint += "_"
            } else {
                hint += String(char)
            }
            if empty {
                empty = false
            }
        }
        
        return hint
    }
}

#Preview {
    PuzzleHint(artistName: "Big K.R.I.T.")
}
