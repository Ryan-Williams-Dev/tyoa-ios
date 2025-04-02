//
//  ProfileView.swift
//  TYOA
//
//  Created by Ryan Williams on 2025-03-28.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var isPresentingConfirmation: Bool = false
    @State private var password: String = ""
    @State private var showReauthDialog: Bool = false
    
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
                        isPresentingConfirmation = true
                    } label: {
                        SettingsRowView(imageName: "xmark.circle.fill", title: "Delete Account", tintColor: Color.red)
                    }
                    .confirmationDialog(
                        "Delete Account",
                        isPresented: $isPresentingConfirmation,
                        titleVisibility: .visible
                    ) {
                        Button("Delete", role: .destructive) {
                            showReauthDialog = true
                        }
                        
                        Button("Cancel", role: .cancel) {
                        }
                    } message: {
                        Text("Are you sure you want to delete your account? This action cannot be undone, and all your data will be permanently lost.")
                    }
                }
            }
            .alert("Confirm with Password", isPresented: $showReauthDialog) {
                SecureField("Password", text: $password)
                
                Button("Cancel", role: .cancel) {
                    password = ""
                }
                
                Button("Delete Account", role: .destructive) {
                    Task {
                        if await authViewModel.reauthenticateUser(password: password) {
                            await authViewModel.deleteUser()
                        }
                        password = ""
                    }
                }
            } message: {
                Text("For security, please enter your password to delete your account.")
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
