//
//  HomeStatsView.swift
//  CryptoTracker
//
//  Created by Shivakumar Harijan on 05/07/25.
//

import SwiftUI

struct HomeStatsView: View {
    @Binding var showPortfolio: Bool
    @EnvironmentObject var vm: HomeViewModal
    var body: some View {
        HStack() {
            ForEach(vm.statistics) { stat in
                StatisticView(stats: stat)
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
        }
        .frame(width: UIScreen.main.bounds.width,
               alignment: showPortfolio ? .trailing : .leading)
    }
}

#Preview {
    HomeStatsView(showPortfolio: .constant(false))
        .environmentObject(DeveloperMockData.instance.homeVM)
}
