//
//  ProfileView.swift
//  TYOA
//
//  Created by Ryan Williams on 2025-03-28.
//

import SwiftUI

struct ProfileView: View {
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
    
    var body: some View {
        List {
            Section {
                HStack {
                    Text("RW")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.white)
                        .frame(width: 72, height: 72)
                        .background(Color.secondary.opacity(0.4))
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Ryan Williams")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        Text("ryan@example.com")
                            .font(.footnote)
                            .accentColor(Color.secondary)
                    }
                }
                
                
            }
            
            Section("General") {
                HStack {
                    SettingsRowView(imageName: "gear", title: "Version")
                    Spacer()
                    Text("1.0.0").font(.subheadline).foregroundStyle(.secondary)
                }
                
            }
            
            Section("Account") {
                Button {
                    print("Change password button")
                } label: {
                    SettingsRowView(imageName: "pencil", title: "Change Password")
                }
                
                Button {
                    isLoggedIn = false
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

#Preview {
    ProfileView()
}
