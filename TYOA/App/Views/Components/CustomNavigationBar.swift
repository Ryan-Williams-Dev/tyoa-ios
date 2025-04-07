//
//  CustomNavigationBar.swift
//  TYOA
//
//  Created by Ryan Williams on 2025-04-06.
//

import SwiftUI

struct CustomNavigationBar: ViewModifier {
    var title: String = "Echo."
    var hasSettings: Bool = true
    @Binding var navigationPath: NavigationPath
    
    func body(content: Content) -> some View {
        content
            .toolbar {
                if navigationPath.isEmpty {
                    ToolbarItem(placement: .topBarLeading) {
                        Image("logo")
                            .resizable()
                            .frame(width: 44, height: 44)
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    Text(title)
                        .fontWeight(.bold)
                        .font(.title2)
                }
                
                if hasSettings {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            navigationPath.append("profile")
                        } label: {
                            Image(systemName: "gearshape")
                                .foregroundColor(.primary)
                                .font(.title2)
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
    }
}

extension View {
    func customNavigationBar(
        title: String = "Echo.",
        hasSettings: Bool = true,
        navigationPath: Binding<NavigationPath>
    ) -> some View {
        self.modifier(CustomNavigationBar(
            title: title,
            hasSettings: hasSettings,
            navigationPath: navigationPath
        ))
    }
}
#Preview {
    let mockViewModel = AuthViewModel()
    mockViewModel.currentUser = User(
        id: "test-user-id",
        email: "test@example.com",
        fullName: "Test User"
    )
    
    return HomeView()
        .environmentObject(mockViewModel)
}
