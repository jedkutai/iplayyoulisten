//
//  FlatLabel.swift
//  iplayyoulisten
//
//  Created by Jed Kutai on 6/28/24.
//

import SwiftUI

struct FlatLabel: View {
    let text: String
    var body: some View {
        Text(text)
            .foregroundStyle(.white)
            .font(.subheadline)
            .frame(maxWidth: .infinity)
            .padding(5)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(.black)
            )
    }
}

#Preview {
    FlatLabel(text: "Next")
}
