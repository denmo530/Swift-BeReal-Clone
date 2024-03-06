//
//  SignInView.swift
//  bereal-clone
//
//  Created by Dennis Moradkhani on 2024-03-04.
//

import SwiftUI



struct SignInView: View {
    @State var email = ""
    @State var password = ""
    @State var isLoading = false
    @State var result: Result<Void, Error>?
    var body: some View {
        ZStack {
            
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .zIndex(1)
                    .scaleEffect(1.5)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.black.opacity(0.3))
                    .padding(0)
            }
           
            Color(UIColor(named: "BodyColor")!).ignoresSafeArea()
          
            VStack {
                Text("BeReal Clone 📸.")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 42)
                    .foregroundStyle(.white)
                
                if let result {
                    Section {
                        switch result {
                        case .success:
                            Text("Loggin in...")
                        case .failure(let error):
                            Text(error.localizedDescription)
                                .fontWeight(.medium)
                                .foregroundStyle(.red)
                        }
                    }
                }
                
                VStack (spacing: 16) {
                    InputFieldView(
                        data: $email,
                        title: "Email",
                        textContentType: .emailAddress
                    )
                    InputFieldView(
                        data: $password,
                        title: "Password",
                        isSecureField: true,
                        textContentType: .password
                    )

                }
                .padding(.bottom, 16)
                HStack (spacing: 8) {
                    Button(action: signInHandler) {
                        Label("Sign In", systemImage: "person.fill")
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                            .padding()
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .background(Color("ThemeColor"))
                            .cornerRadius(10)
                    }
                    Button(action: magicLinkHandler) {
                        Label("Link", systemImage: "wand.and.stars")
                            .padding()
                            .foregroundColor(.white)
                            .fontWeight(.heavy)
                            .background(Color("ThemeColor"))
                            .multilineTextAlignment(.center)
                            .cornerRadius(10)
                    }
                }
                
                HStack {
                    Spacer()
                    Text("Forgotten Password?")
                        .fontWeight(.thin)
                        .foregroundStyle(Color(.white))
                        .underline()
                }
                .padding(.top, 10)
            }
            .padding()
            
        }
        .onOpenURL(perform: { url in
            Task {
                do {
                    try await supabase.auth.session(from: url)
                } catch {
                    self.result = .failure(error)
                }
            }
    })
    }
    
    
    func signInHandler() {
        Task {
            isLoading = true
            defer {isLoading = false}
            
            do {
                try await supabase.auth.signIn(
                    email: email,
                    password: password
                )
                result = .success(())
            } catch {
                result = .failure(error)
            }
        }
    }


    func magicLinkHandler() {
        Task {
            isLoading = true
            defer { isLoading = false }
            
            do {
                try await supabase.auth.signInWithOTP(
                    email: email,
                    redirectTo: URL(string: "bereal-clone://login-callback")
                )
                result = .success(())
            } catch {
                result = .failure(error)
            }
        }
    }
        
}


#Preview {
    SignInView()
}
