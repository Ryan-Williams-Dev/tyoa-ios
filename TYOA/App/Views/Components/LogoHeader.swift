//
//  LogoHeader.swift
//  TYOA
//
//  Created by Ryan Williams on 2025-04-02.
//

import SwiftUI

struct LogoHeader: View {
    var body: some View {
        VStack(spacing: 8) {
            Image("logo")
                .resizable()
                .frame(width: 200, height: 200)
            Text("Echo.")
                .font(.largeTitle)
                .fontWeight(.bold)
        }
    }
}

#Preview {
    LogoHeader()
}
