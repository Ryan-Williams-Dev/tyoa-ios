//
//  SettingsRowView.swift
//  TYOA
//
//  Created by Ryan Williams on 2025-03-28.
//

import SwiftUI

struct SettingsRowView: View {
    let imageName: String
    let title: String
    var tintColor: Color = .secondary
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: imageName)
                .foregroundColor(tintColor)
                .font(.title)
            Text(title)
                .font(.subheadline)
                .foregroundStyle(.primaryText)
        }
    }
}

struct SettingsRowView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsRowView(imageName: "gear", title: "Version")
    }
}
