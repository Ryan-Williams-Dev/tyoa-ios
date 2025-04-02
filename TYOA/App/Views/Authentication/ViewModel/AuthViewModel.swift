//
//  AuthViewModel.swift
//  TYOA
//
//  Created by Ryan Williams on 2025-03-29.
//

import Foundation
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

@MainActor
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    
    private let auth = Auth.auth()
    
    init() {
        self.userSession = auth.currentUser
        
        Task {
            if userSession != nil {
                await fetchUserData()
            }
        }
    }
    
    
    func signIn(withEmail email: String, password: String) async throws {
        self.errorMessage = nil
        self.isLoading = true
        
        do {
            let result = try await auth.signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUserData()
            self.isLoading = false
        } catch {
            self.isLoading = false
            self.errorMessage = error.localizedDescription
            throw error
        }
    }
    
    func createUser(withEmail email: String, password: String, fullName: String) async throws {
        self.isLoading = true
        self.errorMessage = nil
        
        do {
            let result = try await auth.createUser(withEmail: email, password: password)
            self.userSession = result.user
            
            let user = User(id: result.user.uid, email: email, fullName: fullName)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(result.user.uid).setData(encodedUser)
            
            self.currentUser = user
            self.isLoading = false
        } catch {
            self.isLoading = false
            self.errorMessage = "Failed to create account: \(error.localizedDescription)"
            print("DEBUG: Error creating user: \(error.localizedDescription)")
            throw error
        }
    }
    
    func signOut() async {
        self.errorMessage = nil
        
        do {
            try auth.signOut()
            self.userSession = nil
            self.currentUser = nil
        } catch {
            self.errorMessage = "Failed to sign out: \(error.localizedDescription)"
        }
    }
    
    func deleteUser() async {
        guard let user = auth.currentUser else {
            self.errorMessage = "No user is currently signed in"
            return
        }
        
        self.isLoading = true
        self.errorMessage = nil
        
        do {
            try await Firestore.firestore().collection("users").document(user.uid).delete()
            
            try await user.delete()
            
            self.userSession = nil
            self.currentUser = nil
            
            print("DEBUG: User successfully deleted")
        } catch {
            print("DEBUG: Error deleting user: \(error.localizedDescription)")
            self.errorMessage = "Failed to delete account: \(error.localizedDescription)"
        }
        
        self.isLoading = false
    }
    
    func fetchUserData() async {
        guard let uid = auth.currentUser?.uid else {
            print("DEBUG: No authenticated user found")
            return
        }
        
        do {
            self.isLoading = true
            
            let docSnapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
            
            if docSnapshot.exists {
                let user = try docSnapshot.data(as: User.self)
                self.currentUser = user
            } else {
                print("DEBUG: User document does not exist for uid: \(uid)")
                await signOut()
                self.errorMessage = "Your account data could not be found. You have been signed out."
            }
        } catch {
            print("DEBUG: Error fetching user data: \(error.localizedDescription)")
            self.errorMessage = "Failed to load profile: \(error.localizedDescription)"
        }
        
        self.isLoading = false
    }
    
    func resetPassword(forEmail email: String) async -> Bool {
        self.isLoading = true
        self.errorMessage = nil
        
        do {
            try await auth.sendPasswordReset(withEmail: email)
            self.isLoading = false
            return true
        } catch {
            self.isLoading = false
            self.errorMessage = "Failed to send password reset: \(error.localizedDescription)"
            return false
        }
    }
    
    func reauthenticateUser(password: String) async -> Bool {
        guard let user = auth.currentUser, let email = user.email else {
            self.errorMessage = "No current user found"
            return false
        }
        
        self.isLoading = true
        
        do {
            let credential = EmailAuthProvider.credential(withEmail: email, password: password)
            try await user.reauthenticate(with: credential)
            self.isLoading = false
            return true
        } catch {
            self.errorMessage = "Re-authentication failed: \(error.localizedDescription)"
            print("DEBUG: Re-authentication error: \(error.localizedDescription)")
            self.isLoading = false
            return false
        }
    }
}

