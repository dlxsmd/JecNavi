//
//  SplashScreenView.swift
//  JecNavi
//
//  Created by yuki on 2024/07/03.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var size = 0.9
    @State private var opsity = 0.5
    
    var body: some View {
        if isActive {
            IntroTabView()
        } else {
            VStack {
                    Image("applogo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                .scaleEffect(size)
                .opacity(opsity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.2)) {
                        self.size = 1.0
                        self.opsity = 1.0
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
