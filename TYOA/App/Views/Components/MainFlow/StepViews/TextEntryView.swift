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
            Text("What advice would you give to someone struggling with their mood today?")
                .font(.headline)
                .foregroundStyle(.secondary)
            
            TextEditor(text: $adviceText)
                .focused($isTextFieldFocused)
                .onChange(of: adviceText) { _, _ in
                    moodEntryVM.updateAdviceText(to: adviceText)
                }
                .frame(minHeight: 150)
                .padding(8)
                .background(.cardBackground)
                .cornerRadius(12)
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

//#Preview {
//    TextEntryView()
//}
