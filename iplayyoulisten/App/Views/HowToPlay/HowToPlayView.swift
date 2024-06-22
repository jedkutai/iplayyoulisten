//
//  HowToPlayView.swift
//  iplayyoulisten
//
//  Created by Jed Kutai on 6/18/24.
//

import SwiftUI

struct HowToPlayView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                MenuBackground()
                
                VStack {
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(alignment: .leading) {
                            
                        }
                    }
                }
            }
            .navigationTitle("How To Play")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    HowToPlayView()
}
