//
//  AuthView.swift
//  bereal-clone
//
//  Created by Dennis Moradkhani on 2024-03-04.
//

import SwiftUI
import Supabase

enum AuthTab {
    case signIn, signUp
}

struct AuthView: View {
    @State private var selectedTab: AuthTab = .signIn
    
    var body: some View {
        
        VStack {
            // Custom Tab Bar
            HStack(spacing: 0) {
                Spacer()
                Button("Sign In") {
                    selectedTab = .signIn
                }
                .foregroundColor(selectedTab == .signIn ? .white : .gray)
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
                .background(selectedTab == .signIn ?             Color(UIColor(named: "ThemeColor")!)
                            : Color(UIColor(named: "ThemeColor")!).opacity(0.8))
                .clipShape(RoundedCorners(tl: 12, tr: 0, bl: 12, br: 0))
                
                Button("Sign Up") {
                    selectedTab = .signUp
                }
                .foregroundColor(selectedTab == .signUp ? .white : .gray)
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
                .background(selectedTab == .signUp ? Color(UIColor(named: "ThemeColor")!) : Color(UIColor(named: "ThemeColor")!).opacity(0.8))
                .clipShape(RoundedCorners(tl: 0, tr: 12, bl: 0, br: 12))
                Spacer()
            }
            .padding()
        }
        

        
        switch selectedTab {
        case .signIn:
            SignInView()

        case .signUp:
            SignUpView()
        }
        
        Spacer()
    }

    struct RoundedCorners: Shape {
        var tl: CGFloat = 0.0
        var tr: CGFloat = 0.0
        var bl: CGFloat = 0.0
        var br: CGFloat = 0.0

        func path(in rect: CGRect) -> Path {
            var path = Path()

            let w = rect.size.width
            let h = rect.size.height

            // Make sure we do not exceed the size of the rectangle
            let tr = min(min(self.tr, h/2), w/2)
            let tl = min(min(self.tl, h/2), w/2)
            let bl = min(min(self.bl, h/2), w/2)
            let br = min(min(self.br, h/2), w/2)

            path.move(to: CGPoint(x: w / 2.0, y: 0))
            path.addLine(to: CGPoint(x: w - tr, y: 0))
            path.addArc(center: CGPoint(x: w - tr, y: tr), radius: tr,
                        startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
            path.addLine(to: CGPoint(x: w, y: h - br))
            path.addArc(center: CGPoint(x: w - br, y: h - br), radius: br,
                        startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
            path.addLine(to: CGPoint(x: bl, y: h))
            path.addArc(center: CGPoint(x: bl, y: h - bl), radius: bl,
                        startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
            path.addLine(to: CGPoint(x: 0, y: tl))
            path.addArc(center: CGPoint(x: tl, y: tl), radius: tl,
                        startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
            path.closeSubpath()

            return path
        }
    }
}


#Preview {
    AuthView()
}
