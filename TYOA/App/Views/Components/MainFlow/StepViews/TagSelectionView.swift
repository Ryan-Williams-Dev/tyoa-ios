//
//  TagSelectionView.swift
//  TYOA
//
//  Created by Ryan Williams on 2025-04-07.
//

import SwiftUI

struct TagSelectionView: View {
    @Binding var selectedTags: [String]
    
    private let availableTags = [
        "Exercise", "Work", "Family", "Friends", "Reading",
        "Gaming", "Shopping", "Learning", "Cooking", "Outdoors",
        "Social Media", "TV", "Movies", "Music", "Sleep"
    ]
    
    var body: some View {
        VStack(spacing: 24) {
            Text("What activities influenced your mood today?")
                .font(.title2)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
            
            ScrollView {
                FlowLayout(spacing: 8) {
                    ForEach(availableTags, id: \.self) { tag in
                        tagButton(for: tag)
                    }
                }
                .padding(.vertical)
            }
        }
        .padding()
    }
    
    private func tagButton(for tag: String) -> some View {
        let isSelected = selectedTags.contains(tag)
        
        return Button(action: {
            if isSelected {
                selectedTags.removeAll { $0 == tag }
            } else {
                selectedTags.append(tag)
            }
        }) {
            Text(tag)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(isSelected ? Color.primaryButton : Color.gray.opacity(0.2))
                .foregroundColor(isSelected ? Color.primaryButtonText : .primary)
                .cornerRadius(16)
        }
    }
}

// A simple flow layout to wrap tags
struct FlowLayout: Layout {
    var spacing: CGFloat
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let width = proposal.width ?? 0
        
        var height: CGFloat = 0
        var x: CGFloat = 0
        var y: CGFloat = 0
        var rowHeight: CGFloat = 0
        
        for view in subviews {
            let viewSize = view.sizeThatFits(.unspecified)
            
            if x + viewSize.width > width {
                // Start new row
                x = 0
                y += rowHeight + spacing
                rowHeight = 0
            }
            
            rowHeight = max(rowHeight, viewSize.height)
            x += viewSize.width + spacing
            height = max(height, y + rowHeight)
        }
        
        return CGSize(width: width, height: height)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        var x: CGFloat = bounds.minX
        var y: CGFloat = bounds.minY
        var rowHeight: CGFloat = 0
        
        for view in subviews {
            let viewSize = view.sizeThatFits(.unspecified)
            
            if x + viewSize.width > bounds.maxX {
                // Start new row
                x = bounds.minX
                y += rowHeight + spacing
                rowHeight = 0
            }
            
            view.place(
                at: CGPoint(x: x, y: y),
                proposal: ProposedViewSize(width: viewSize.width, height: viewSize.height)
            )
            
            rowHeight = max(rowHeight, viewSize.height)
            x += viewSize.width + spacing
        }
    }
}

struct TagSelectionView_Previews: PreviewProvider {
    @State static var selectedTags: [String] = ["Exercise", "Reading"]
    
    static var previews: some View {
        TagSelectionView(selectedTags: $selectedTags)
            .padding()
            .withAppBackground()
    }
}
