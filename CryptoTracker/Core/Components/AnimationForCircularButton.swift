//
//  AnimationForCircularButton.swift
//  CryptoTracker
//
//  Created by Shivakumar Harijan on 23/06/25.
//

import SwiftUI

struct AnimationForCircularButton: View {
    
    @Binding var isAnimating: Bool
    var body: some View {
        Circle()
            .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round))
        //for single effect
//            .scale(1.0)
//            .opacity(0)
//            .transition(.scale.combined(with: .opacity))
        // if want to include reverse ripple effect
        
            .scaleEffect(isAnimating ? 1.0 : 0.0)
            .opacity(isAnimating ? 0.0 : 1.0)
            .animation(.easeOut(duration: 1.0), value: isAnimating)
        
//            .onAppear() {
//                isAnimating.toggle()
//            }
    }
}

#Preview {
//    AnimationForCircularButton()
//        .frame(width: 100, height: 100)
    
        AnimationForCircularButton(isAnimating: .constant(false))
}
