//
//  TagSelectionView.swift
//  TYOA
//
//  Created by Ryan Williams on 2025-04-07.
//

import SwiftUI

struct TagSelectionView: View {
    @Binding var selectedTags: Set<String>
    
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
                MoodCardView(moodTag: DummyData.moodTags[index], selectedTags: $selectedTags)
                    .aspectRatio(5/6, contentMode: .fit)
            }
        }
    }
}

struct MoodCardView: View {
    let moodTag: MoodTag
    @Binding var selectedTags: Set<String>
    
    private var isSelected: Bool {
        selectedTags.contains(moodTag.slug)
    }
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: moodTag.iconName ?? "face.smile")
                .font(.system(size: 32))
                .foregroundColor(isSelected ? .cardBackground : .primary)
                .frame(height: 50)
                .padding(.top, 8)
            
            Text(moodTag.name)
                .font(.headline)
                .foregroundColor(isSelected ? .cardBackground : .primary)
                .multilineTextAlignment(.center)
                .padding(.bottom, 12)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(
                            isSelected ?
                            LinearGradient(
                                gradient: Gradient(colors: [Color.primary, Color.primary.opacity(0.8)]),
                                startPoint: .top,
                                endPoint: .bottom
                            ) :
                            LinearGradient(
                                gradient: Gradient(colors: [Color.cardBackground, Color.cardBackground.opacity(0.85)]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(isSelected ? Color.primary : Color.primary.opacity(0.1), lineWidth: isSelected ? 2 : 1)
                )
                .shadow(color: isSelected ? Color.primary.opacity(0.3) : Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        .padding(4)
        .contentShape(RoundedRectangle(cornerRadius: 16))
        .onTapGesture {
            withAnimation(.spring(response: 0.3)) {
                toggleSelection()
            }
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
        }
        .scaleEffect(isSelected ? 1.03 : 1.0)
    }
    
    private func toggleSelection() {
        if isSelected {
            selectedTags.remove(moodTag.slug)
        } else {
            selectedTags.insert(moodTag.slug)
        }
    }
}
struct TagSelectionView_Previews: PreviewProvider {
    @State static var selectedTags: Set<String> = ["confident"]
    
    static var previews: some View {
        TagSelectionView(selectedTags: $selectedTags)
            .padding()
//            .withAppBackground()
    }
}

