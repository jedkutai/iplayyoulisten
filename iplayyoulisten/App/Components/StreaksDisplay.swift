//
//  StreaksDisplay.swift
//  iplayyoulisten
//
//  Created by Jed Kutai on 6/25/24.
//

import SwiftUI

struct StreaksDisplay: View {
    @EnvironmentObject var x: X
    var body: some View {
        HStack {
            Image(systemName: "flame")
                .foregroundStyle(.black)
            
            Text("\(x.twoOrMoreCorrect)")
                .foregroundStyle(.black)
        }
    }
}

//#Preview {
//    StreaksDisplay()
//}
