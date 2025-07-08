//
//  StatisticView.swift
//  CryptoTracker
//
//  Created by Shivakumar Harijan on 04/07/25.
//

import SwiftUI

struct StatisticView: View {
    
    let stats : StatisticsModal
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(stats.title)
                .font(.caption)
                .foregroundColor(Color.themeColors.accent)
            Text(stats.value)
                .font(.headline)
                .foregroundColor(Color.themeColors.accent)
            HStack(spacing: 5) {
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(
                        Angle(degrees: (stats.percentageChange ?? 0) >= 0 ? 0 : 180 )
                    )
                Text(stats.percentageChange?.asNumberWithPercentageSign() ?? "")
                    .font(.caption)
                    .bold()
            }
            .foregroundColor(
                (stats.percentageChange ?? 0) >= 0 ? Color.themeColors.green :
                    Color.themeColors.red
            )
            .opacity(stats.percentageChange == nil ? 0 : 1)
            
        }
    }
}

#Preview {
    StatisticView(stats: DeveloperMockData.instance.stats1)
}
