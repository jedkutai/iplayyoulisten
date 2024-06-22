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
                                
                                Text("- Capitalization **DOES NOT** matter. yOu CaN aNsWeR lIkE tHiS iF yOuR hEaRt DeSiReS.")
                                Text("- You must match every character, if there is a fancy letter like the **é** in Beyoncé, the hint will tell you.")
                                Text("- You can long press on your keyboard to type special characters. To type the fancy **é**, long press your **e** key.")
                            }
                            .foregroundStyle(.black)
                            
                        }
                        .padding()
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
