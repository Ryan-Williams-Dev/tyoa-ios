//
//  ProfileView.swift
//  TYOA
//
//  Created by Ryan Williams on 2025-03-28.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        if let user = authViewModel.currentUser {
            List {
                Section {
                    HStack(spacing: 16) {
                        Text(user.initials)
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(Color.white)
                            .frame(width: 72, height: 72)
                            .background(Color.secondary.opacity(0.4))
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(user.fullName)
                                .font(.title3)
                                .fontWeight(.semibold)
                            Text(user.email)
                                .font(.subheadline)
                                .foregroundColor(Color.secondary)
                        }
                    }
                    
                    
                }
                
                Section("General") {
                    HStack {
                        SettingsRowView(imageName: "gear", title: "Version")
                        Spacer()
                        Text("0.1.0").font(.subheadline).foregroundStyle(.secondary)
                    }
                    
                }
                
                Section("Account") {
                    Button {
                        print("Change password button")
                    } label: {
                        SettingsRowView(imageName: "pencil", title: "Change Password")
                    }
                    
                    Button {
                        Task { await authViewModel.signOut() }
                    } label: {
                        SettingsRowView(imageName: "arrow.left.circle", title: "Sign Out")
                    }
                    
                }
                
                Section("Danger Zone") {
                    Button {
                        print("Delete Account...")
                    } label: {
                        SettingsRowView(imageName: "xmark.circle.fill", title: "Delete Account", tintColor: Color.red)
                    }
                }
            }
        }
    }
}

#Preview {
    let mockViewModel = AuthViewModel()
    mockViewModel.currentUser = User(
        id: "preview-user-id",
        email: "preview@example.com",
        fullName: "Preview User"
    )
    
    return ProfileView()
        .environmentObject(mockViewModel)
}
