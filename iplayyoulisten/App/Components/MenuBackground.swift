//
//  MenuBackground.swift
//  iplayyoulisten
//
//  Created by Jed Kutai on 6/18/24.
//

import SwiftUI

struct MenuBackground: View {
    var body: some View {
        ZStack {
            Color(.white)
            
            LinearGradient(
                colors: [
                    CustomColors.purlpe2,
                    CustomColors.purlpe1
//                    Color(.white),
//                    CustomColors.cream
                    
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
    MenuBackground()
}
