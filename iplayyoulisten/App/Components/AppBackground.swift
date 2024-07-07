//
//  AppBackground.swift
//  iplayyoulisten
//
//  Created by Jed Kutai on 6/27/24.
//

import SwiftUI

struct AppBackground: View {
    var body: some View {
        ZStack {
            Color(.white)
            
            LinearGradient(
                colors: [
                    Color.purlpe2,
                    Color.purlpe1
                ],
                startPoint: .top, endPoint: .bottom
            )
            
            Rectangle()
                .foregroundStyle(.ultraThinMaterial)
                
        }
        .ignoresSafeArea()
    }
}

#Preview {
    AppBackground()
}
