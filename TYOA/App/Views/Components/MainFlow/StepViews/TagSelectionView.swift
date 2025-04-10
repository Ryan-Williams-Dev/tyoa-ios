//
//  TagSelectionView.swift
//  TYOA
//
//  Created by Ryan Williams on 2025-04-07.
//

import SwiftUI

struct TagSelectionView: View {
    @Binding var selectedTags: [MoodTag]
    
    var body: some View {
        ScrollView {
            moodcards
        }
    }
    
    let columns = [
        GridItem(.adaptive(minimum: 100)),
    ]
    
    var moodcards: some View {
        LazyVGrid(columns: columns, spacing: 12) {
            ForEach(DummyData.moodTags.indices, id: \.self) { index in
                MoodCardView(moodTag: DummyData.moodTags[index])
                    .aspectRatio(3/4, contentMode: .fit)
            }
        }
    }
}

struct MoodCardView: View {
    let moodTag: MoodTag
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: moodTag.iconName ?? "face.smile")
                .font(.system(size: 32))
                .foregroundColor(.primary)
                .frame(height: 50)
                .padding(.top, 8)
            
            Text(moodTag.name)
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.bottom, 12)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.cardBackground, Color.cardBackground.opacity(0.85)]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.primary.opacity(0.1), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        .padding(4)
        .contentShape(RoundedRectangle(cornerRadius: 16))
        .buttonStyle(PlainButtonStyle())
        .hoverEffect(.lift)
    }
}

struct TagSelectionView_Previews: PreviewProvider {
    @State static var selectedTags: [MoodTag] = DummyData.moodTags
    
    static var previews: some View {
        TagSelectionView(selectedTags: $selectedTags)
            .padding()
            .withAppBackground()
    }
}

