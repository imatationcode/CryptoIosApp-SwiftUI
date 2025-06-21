//
//  CircularButton.swift
//  CryptoTracker
//
//  Created by Shivakumar Harijan on 21/06/25.
//

import SwiftUI

struct CircularButtonView: View {
    let iconName: String
    var body: some View {
            Image(systemName: iconName)
                .foregroundColor(Color.themeColors.accent)
                .frame(width: 50, height: 50)
                .background(
                    Circle()
                        .fill(Color.themeColors.background)
                )
                .shadow(
                    color: Color.themeColors.accent.opacity(0.3), radius: 10.0)
                .padding()
    }
}

#Preview {
    Group {
        
        CircularButtonView(iconName: "sun.max.fill")
            .preferredColorScheme(.light)
    }
}
