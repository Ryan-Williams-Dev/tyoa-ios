//
//  SliderView.swift
//  TYOA
//
//  Created by Ryan Williams on 2025-04-07.
//

import SwiftUI

struct SliderView: View {
    @Binding var value: Double
    let minLabel: String
    let maxLabel: String
    let minIcon: String
    let maxIcon: String
    
    var body: some View {
        CustomSlider(
            value: $value,
            minLabel: minLabel,
            maxLabel: maxLabel,
            minIcon: minIcon,
            maxIcon: maxIcon
        )
    }
}
