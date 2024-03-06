//
//  InputFieldView.swift
//  bereal-clone
//
//  Created by Dennis Moradkhani on 2024-03-05.
//

import SwiftUI

struct InputFieldView: View {
    @Binding var data: String
    var title: String?
    var isSecureField: Bool? = false
    var textContentType: UITextContentType?
    
    var body: some View {
        ZStack {
            if isSecureField == true {
                SecureField("", text: $data)
                    .padding(.horizontal, 10)
                    .frame(height: 42)
                    .foregroundStyle(.white)
                    .tint(.white)
                    .overlay(
                        RoundedRectangle(cornerSize: CGSize(width: 4, height: 4))
                            .stroke(Color.white.opacity(0.6), lineWidth: 1)
                )
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .textContentType(textContentType)
                
            } else {
                TextField("", text: $data)
                    .padding(.horizontal, 10)
                    .frame(height: 42)
                    .foregroundStyle(.white)
                    .tint(.white)
                    .overlay(
                        RoundedRectangle(cornerSize: CGSize(width: 4, height: 4))
                            .stroke(Color.white.opacity(0.6), lineWidth: 1)
                )
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .textContentType(textContentType)

            }
            
            HStack {
                Text(title ?? "input")
                    .font(.headline)
                    .fontWeight(.regular)
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.leading)
                    .padding(4)
                    .background(Color("BodyColor"))
                Spacer()
            }
            .padding(.leading, 8)
            .offset(CGSize(width: 0, height: -20))
        }
        .padding(4)
    }
}

struct InputFieldView_Previews: PreviewProvider {
    static var previews: some View {
        // Create a local state variable for the preview
        @State var data: String = ""

        // Return the view with the binding to the local state variable
        InputFieldView(data: $data, title: "Email")
    }
}
