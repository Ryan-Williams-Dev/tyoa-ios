//
//  MoodEntryNavigation.swift
//  TYOA
//
//  Created by Ryan Williams on 2025-04-07.
//

import SwiftUI

struct MoodEntryNavigation: View {
    @ObservedObject var viewModel: MoodEntryViewModel
    
    var body: some View {
        HStack(spacing: 16) {
            // Back button - only show if we can go back
            if viewModel.canMoveToPreviousStep {
                backButton
            }
            
            // Next/Submit button
            nextButton
        }
        .padding(.vertical)
        .padding(.horizontal, 24)
    }
    
    private var backButton: some View {
        Button(action: { viewModel.goToPreviousStep() }) {
            Image(systemName: "chevron.left")
                .fontWeight(.semibold)
                .font(.title2)
                .padding()
                .foregroundColor(.primary)
                .cornerRadius(12)
        }.overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.primary.opacity(0.1), lineWidth: 2)
        )
    }
    
    private var nextButton: some View {
        Button(action: {
            if viewModel.isLastStep {
                viewModel.submitEntryData()
            } else {
                viewModel.goToNextStep()
            }
        }) {
            Text(viewModel.isLastStep ? "Submit" : "Next")
                .fontWeight(.semibold)
                .font(.title2)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.primaryButton)
                .foregroundColor(Color.primaryButtonText)
                .cornerRadius(12)
        }
    }
}
