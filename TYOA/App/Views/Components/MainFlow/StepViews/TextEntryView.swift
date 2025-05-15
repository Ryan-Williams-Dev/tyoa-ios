//
//  TextEntryView.swift
//  TYOA
//
//  Created by Ryan Williams on 2025-04-15.
//

import SwiftUI

struct TextEntryView: View {
    @EnvironmentObject var moodEntryVM: MoodEntryViewModel
    @State private var adviceText: String = ""
    @FocusState private var isTextFieldFocused: Bool
    
    
    var body: some View {
        ScrollView {
            Text(moodEntryVM.adviceQuestion)
                .font(.headline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
            
            ZStack {
                TextEditor(text: $adviceText)
                    .focused($isTextFieldFocused)
                    .onChange(of: adviceText) { _, _ in
                        moodEntryVM.updateAdviceText(to: adviceText)
                    }
                    .frame(minHeight: 150)
                    .padding(.vertical, 2)
                    .padding(.horizontal, 10)
                    .scrollContentBackground(.hidden)
            }
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .strokeBorder(Color.primary.opacity(0.2), lineWidth: 2)
            )
            .background(.cardBackground)
            .cornerRadius(16)
            
           
        }
        .padding(.horizontal, 24)
        .onAppear {
            adviceText = moodEntryVM.adviceText
        }
        .onDisappear {
            isTextFieldFocused = false
        }
        .onChange(of: moodEntryVM.currentStep) { _, newStep in
            if newStep != MoodEntryViewModel.EntryStep.adviceText.rawValue {
                isTextFieldFocused = false
            }
        }
        .scrollDismissesKeyboard(.interactively)
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") {
                    isTextFieldFocused = false
                }
            }
        }
    }
    
}

struct TextEntryView_Previews: PreviewProvider {
    static var previews: some View {
        TextEntryView()
            .environmentObject(MoodEntryViewModel())
            .withAppBackground()
    }
}
