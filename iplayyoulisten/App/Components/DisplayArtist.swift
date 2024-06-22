//
//  DisplayArtist.swift
//  iplayyoulisten
//
//  Created by Jed Kutai on 6/20/24.
//

import SwiftUI

struct DisplayArtist: View {
    let artistName: String
    
    var body: some View {
        Text(self.displayArtist())
            .font(.title.weight(.bold))
            .foregroundStyle(.black)
            .lineLimit(1)
            .minimumScaleFactor(0.1)
    }
    
    private func displayArtist() ->  String {
        var hint: String = ""
        
        var empty: Bool = true
        
        for char in artistName {
            if !empty {
                hint += " "
            }
            
            hint += String(char)
            
            if empty {
                empty = false
            }
        }
        
        return hint
    }
}

#Preview {
    DisplayArtist(artistName: "Beyoncé the G.O.A.T.")
}
