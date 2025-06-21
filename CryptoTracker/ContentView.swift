//
//  ContentView.swift
//  CryptoTracker
//
//  Created by Shivakumar Harijan on 11/06/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
                .foregroundColor(Color.red)
                .bold()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
