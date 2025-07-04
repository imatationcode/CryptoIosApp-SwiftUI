//
//  SearchBarView.swift
//  CryptoTracker
//
//  Created by Shivakumar Harijan on 04/07/25.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText: String
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(
                    searchText.isEmpty ? Color.themeColors.gray : Color.themeColors.accent
                )
            
            TextField("Search Coin by Name or Symbol....", text: $searchText)
                .foregroundColor(Color.themeColors.accent)
                .autocorrectionDisabled(true)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10)
                        .foregroundColor(Color.themeColors.accent)
                        .opacity(searchText.isEmpty ? 0 : 1)
                        .onTapGesture {
                            UIApplication.shared.endEdit()
                            searchText = ""
                        }
                    , alignment: .trailing)
            
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.themeColors.background)
                .shadow(
                    color: Color.themeColors.accent.opacity(0.25), radius: 10, x: 0, y: 0
                )
        )
        .padding()
        
    }
}

#Preview {
    SearchBarView(searchText: .constant(""))
}
