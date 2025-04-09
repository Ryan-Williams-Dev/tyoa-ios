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
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(DummyData.moodTags.indices, id: \.self) { index in
                MoodCardView(moodTag: DummyData.moodTags[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
    }
}

struct MoodCardView: View {
    let moodTag: MoodTag
    
    var body: some View {
        VStack {
            Image(systemName: moodTag.iconName ?? "face.smile")
                .foregroundColor(.primary)
            Text(moodTag.name)
        }
        .background(Color.cardBackground)
        .padding()
        
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
