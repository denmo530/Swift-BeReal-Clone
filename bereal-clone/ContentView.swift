//
//  ContentView.swift
//  bereal-clone
//
//  Created by Dennis Moradkhani on 2024-03-04.
//

import SwiftUI

struct ContentView: View {
    @State var isAuthenticated = false
    
    var body: some View {
        ZStack() {
            Color(UIColor(named: "BodyColor")!).ignoresSafeArea()
            
            VStack {
                Group {
                    if isAuthenticated {
                        ProfileView()
                    } else {
                        AuthView()
                    }
                }
                .task {
                    for await (event, session) in await supabase.auth.authStateChanges {
                        if [.initialSession, .signedIn, .signedOut].contains(event) {
                            isAuthenticated = session != nil
                        }
                    }
            }
            }
        }
    }
}

#Preview {
    ContentView()
}
