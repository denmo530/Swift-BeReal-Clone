//
//  ProfileView.swift
//  bereal-clone
//
//  Created by Dennis Moradkhani on 2024-03-04.
//

import SwiftUI

struct ProfileView: View {
    @State var username = ""
    @State var fullName = ""
    @State var website = ""
    
    @State var isLoading = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section {
                        TextField("Username", text: $username)
                                   .textContentType(.username)
                                   .textInputAutocapitalization(.never)
                                 TextField("Full name", text: $fullName)
                                   .textContentType(.name)
                                 TextField("Website", text: $website)
                                   .textContentType(.URL)
                                   .textInputAutocapitalization(.never)
                    }
                    
                    Section {
                        Button("Update Profile") {
                            updateProfileHandler()
                        }
                        .bold()
                        
                        if (isLoading) {
                            ProgressView()
                        }
                    }
                }
                .navigationTitle("Profile")
                .toolbar(content: {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Sign Out", role: .destructive) {
                            Task {
                                try? await supabase.auth.signOut()
                            }
                        }
                    }
            })
            }
        }
        .task {
            await getInitialProfile()
        }
    }
    
    func getInitialProfile() async {
        do {
            let currentUser = try await supabase.auth.session.user
            
            let profile: Profile = try await supabase.database
                .from("profiles")
                .select()
                .eq("id", value: currentUser.id)
                .single()
                .execute()
                .value
            
            self.username = profile.username ?? ""
            self.fullName = profile.fullName ?? ""
            self.website = profile.website ?? ""
        }
        catch {
            debugPrint(error)
        }
    }
    
    func updateProfileHandler() {
        Task {
            isLoading = true
            defer {isLoading = false}
            do {
                let currentUser = try await supabase.auth
                    .session.user
                
                try await supabase.database
                    .from("profiles")
                    .update(UpdateProfileParams(
                        username: username,
                        fullName: fullName,
                        website: website
                    )
                    )
                    .eq("id", value: currentUser.id)
                    .execute()
            }
        catch {
            debugPrint(error)
        }
        }
    }
}

#Preview {
    ProfileView()
}
