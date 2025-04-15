//
//  TagSelectionView.swift
//  TYOA
//
//  Created by Ryan Williams on 2025-04-07.
//

import SwiftUI

struct TagSelectionView: View {
    @EnvironmentObject var viewModel: MoodEntryViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Select all emotions that apply to you today")
                .font(.headline)
                .foregroundStyle(.secondaryText)
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                    ForEach(viewModel.getTags()) { moodtag in
                        MoodCardView(
                            moodTag: moodtag,
                            isSelected: viewModel.tagIsSelected(moodtag),
                            action: { viewModel.toggleTag(moodtag) }
                        )
                    }.aspectRatio(1, contentMode: .fit)
                }
            }
            .padding(.horizontal, 24)
        }
       
    }
}

struct MoodCardView: View {
    let moodTag: MoodTag
    let isSelected: Bool
    let action: () -> Void
    
    let generator = UIImpactFeedbackGenerator(style: .medium)
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: moodTag.iconName ?? "face.smile")
                .font(.system(size: 32))
                               .foregroundColor(isSelected ? .cardBackground : .primary)
                               .frame(height: 50)
                               .padding(.top, 8)
                               .accessibility(hidden: false)
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
                action()
            }
            generator.impactOccurred()
        }
        .scaleEffect(isSelected ? 1.03 : 1.0)
    }
}



#Preview {
    // Create a sample ViewModel for the preview
    let viewModel = MoodEntryViewModel()
    
    
    return TagSelectionView()
        .environmentObject(viewModel)
        .preferredColorScheme(.light)
}

