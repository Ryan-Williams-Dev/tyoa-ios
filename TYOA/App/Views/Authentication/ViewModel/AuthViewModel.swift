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

class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    var isExistingUser: Bool = false
    var errorMessage: String?
    
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
        print(email, password)
    }
    
    func createUser(withEmail email: String, password: String, fullName: String) async throws {
        do {
            let result = try await auth.createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, email: email, fullName: fullName)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(result.user.uid).setData(encodedUser)
        } catch {
            print("DEBUG: Error creating user: \(error.localizedDescription)")
        }
    }
    
    func signOut() async {
        
    }
    
    func deleteUser() async {
        
    }
    
    func fetchUserData() async {
        
    }
    
}

