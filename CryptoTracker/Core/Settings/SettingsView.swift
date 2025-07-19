//
//  SettingsView.swift
//  CryptoTracker
//
//  Created by shivakumar Harijan on 19/07/25.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    
    let tutorialURL = URL(string: "https://www.youtube.com/playlist?list=PLwvDm4Vfkdphbc3bgy_LpLRQ9DDfFGcFu")!
    let resourceURL = URL( string: "https://www.coingecko.com/")!
    
    let personalPortfolioURL = URL( string: "https://github.com/imatationcode")!
    
    var body: some View {
        NavigationView {
            List {
                Section("referance") {
                    VStack(alignment: .leading) {
                        Image("logo")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .cornerRadius(10)
                        Text("The App was made by following the course provided by @SwiftfullThinking on youtube")
                            .font(.callout)
                            .foregroundColor(Color.themeColors.accent)
                    }
                    .padding(.vertical)
                    Link("Subscribe to his channel 🎁", destination: tutorialURL)
                }
                
                Section("Resources") {
                    VStack(alignment: .leading) {
                        Image("coinGeckoLogo")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .cornerRadius(10)
                        Text("Used CoinGecko free API for displaying Data into the App with Restful API")
                            .font(.callout)
                            .foregroundColor(Color.themeColors.accent)
                    }
                    .padding(.vertical)
                    Link("Visit their website 🌐", destination: tutorialURL)
                }
                
                Section("Developer") {
                    VStack(alignment: .leading) {
                        Image("gitHubLogo")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .cornerRadius(10)
                        Text("Aspiring iOS nerd 👨‍💻")
                            .font(.callout)
                            .foregroundColor(Color.themeColors.accent)
                    }
                    .padding(.vertical)
                    Link("Visite ⌨️", destination: personalPortfolioURL)
                }
            }
            .foregroundColor(Color.blue)
            .listStyle(GroupedListStyle())
            .navigationTitle(Text("Settings"))
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    XMarkDissmisButton {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}
