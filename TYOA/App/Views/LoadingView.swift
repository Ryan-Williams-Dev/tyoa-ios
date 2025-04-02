//
//  LoadingView.swift
//  TYOA
//
//  Created by Ryan Williams on 2025-04-02.
//

import SwiftUI
import Combine

struct LoadingView: View {
    @State private var dotIndex = 0
    private let dotOptions: [String] = ["", ".", "..", "..."]
    private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(spacing: 128) {
            Spacer()
            
            VStack(spacing: 8) {
                Image("logo")
                    .resizable()
                    .frame(width: 200, height: 200)
                Text("Echo.")
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
            
            Spacer()
            
            HStack(spacing: 0) {
                            Text("Loading")
                                .font(.title)
                                .monospaced()
                            Text(dotOptions[dotIndex])
                                .font(.title)
                                .monospaced()
                                .frame(width: 56, alignment: .leading)
                                .animation(.easeInOut(duration: 1), value: dotOptions[dotIndex])
                        }
                        .onReceive(timer) { _ in
                            dotIndex = (dotIndex + 1) % dotOptions.count
                        }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)
    }
}

#Preview {
    LoadingView()
}
