//
//  LauchView.swift
//  CryptoTracker
//
//  Created by shivakumar Harijan on 19/07/25.
//

import SwiftUI

struct LauchView: View {
    @State private var showLoadingText: Bool = false
    @State private var loadingText: [String] = "Loading...".map
    {String($0)}
    @State private var loops: Int = 0
    @Binding var showLaunchScreen: Bool
    
    let animationTimer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
    @State private var counter: Int = 0
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea(edges: .all)
            Image("CryptoLogo")
                .resizable()
                .frame(width: 100, height: 100)
                .cornerRadius(10)
            ZStack {
                if showLoadingText {
                    HStack(spacing: 0) {
                        ForEach(loadingText.indices) { index in
                            Text(loadingText[index])
                                .font(.title2)
                                .fontWeight(.heavy)
                                .foregroundColor(Color.green)
                                .offset(y: counter == index ? -5 : 0)
                        }
                    }
                    .transition(AnyTransition.scale.animation(.easeIn))
                }
            }
            .offset(y: 80)
        }
        .onAppear() {
            showLoadingText.toggle()
        }
        .onReceive(animationTimer) { _ in
            withAnimation(.spring()) {
                let lastIndex = loadingText.count - 1
                if counter == lastIndex {
                    counter = 0
                    loops += 1
                    if loops >= 2 {
                        showLaunchScreen = false
                    }
                } else {
                    counter += 1
                }
            }
        }
    }
}

#Preview {
    LauchView(showLaunchScreen: .constant(true))
}
