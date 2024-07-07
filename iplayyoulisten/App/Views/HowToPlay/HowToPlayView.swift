//
//  HowToPlayView.swift
//  iplayyoulisten
//
//  Created by Jed Kutai on 6/18/24.
//

import SwiftUI

private enum HowToPlayTab: String, CaseIterable {
    case general = "General"
    case hints = "Hints"
}

struct HowToPlayView: View {
    @State private var tabShown: HowToPlayTab = .general
    
    var body: some View {
        NavigationStack {
            ZStack {
                AppBackground()
                
                VStack {
//                    Picker("", selection: $tabShown) {
//                        ForEach(HowToPlayTab.allCases, id: \.self) { tab in
//                            Text(tab.rawValue)
//                                .tag(tab)
//                        }
//                    }
//                    .pickerStyle(.segmented)
//                    .padding(.horizontal)
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        general
//                        switch tabShown {
//                        case .general:
//                            general
//                        case .hints:
//                            hints
//                        }
                    }
                }
            }
            .navigationTitle("How To Play")
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    var general: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            SampleAlbumView()
                
            
            Group {
                Text("Objective:")
                    .fontWeight(.bold)
                    .padding(.top)
                
                Text("Your goal is to guess the name of the artist.")
                    
                
                
                Text("You will be shown:")
                    .fontWeight(.bold)
                    .padding(.top)
                Text("- Genre")
                Text("- Release Year")
                Text("- Pixelated Album Cover")
                Text("- Album Title")
                Text("- Hint for the artist name")
                
                Text("Extra:")
                    .fontWeight(.bold)
                    .padding(.top)
                
                Text("- Apple Music users will get an audio hint if they link their account.")
                
//                Text("- Capitalization **DOES NOT** matter. yOu CaN aNsWeR lIkE tHiS iF yOuR hEaRt DeSiReS.")
//                Text("- You must match every character, if there is a fancy letter like the **é** in Beyoncé, the hint will tell you.")
//                Text("- You can long press on your keyboard to type special characters. To type the fancy **é**, long press your **e** key.")
            }
            .foregroundStyle(.black)
            
        }
        .padding()
    }
    
//    var hints: some View {
//        VStack(alignment: .leading, spacing: 10) {
//            
//            Group {
//                Text("You get awarded 10 hints every time you play a puzzle.")
//                    .fontWeight(.semibold)
//                
//                Text("Hints rollever, if you finish todays puzzle with a few hints remaining, you get to start tomorrow with those hints plus 10 more")
//            }
//            .foregroundStyle(.black)
//        }
//        .padding(.horizontal)
//    }
}




#Preview {
    HowToPlayView()
}
