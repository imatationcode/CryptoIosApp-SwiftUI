//
//  XMarkSheetDissmisButton.swift
//  CryptoTracker
//
//  Created by Shivakumar Harijan on 08/07/25.
//

import SwiftUI

struct XMarkDissmisButton: View {
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
        }
    }
}

#Preview {
    XMarkDissmisButton (action: {
        print("xbutton taped")
    })
}
