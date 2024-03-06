//
//  SignUpView.swift
//  bereal-clone
//
//  Created by Dennis Moradkhani on 2024-03-04.
//

import SwiftUI

struct SignUpView: View {
    @State var email = ""
    @State var password = ""
    @State var username = ""
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
                HStack {
                    Text("Register.")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                    Spacer()
                }
                .padding(.bottom, 42)
                
                
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
                        data: $username,
                        title: "Username",
                        textContentType: .name
                    )
                    InputFieldView(
                        data: $password,
                        title: "Password",
                        isSecureField: true,
                        textContentType: .password
                    )

                }
                .padding(.bottom, 16)
                Button(action: signUpHandler) {
                    Label("Sign Up", systemImage: "person.fill.badge.plus")
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                        .padding()
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .background(Color("ThemeColor"))
                        .cornerRadius(10)
                }
            }.padding()
                
               
            }
        }
    
    
    func signUpHandler() {
        Task {
            do {
                try await supabase.auth.signUp(
                    email: email, 
                    password: password,
                    data: ["full_name": .string(username)]
                )
                result = .success(())
                
            } catch {
                result = .failure(error)
                
            }
            
        }
        
    }
    
    }


#Preview {
    SignUpView()
}


