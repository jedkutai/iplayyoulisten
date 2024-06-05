//
//  ExplicitTag.swift
//  iplayyoulisten
//
//  Created by Jed Kutai on 6/5/24.
//

import SwiftUI

struct ExplicitTag: View {
    var body: some View {
        Image(systemName: "e.square.fill")
            .resizable()
            .scaledToFit()
            .frame(width: 20)
            .foregroundStyle(Color(.systemPink))
    }
}

#Preview {
    ExplicitTag()
}
