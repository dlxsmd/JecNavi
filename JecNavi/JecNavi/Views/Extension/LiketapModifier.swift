//
//  LiketapModifier.swift
//  JecNavi
//
//  Created by Yuki Imai on 2024/07/30.
//

import Foundation
import SwiftUI

struct LikesGeometryEffect : GeometryEffect {
    var time : Double
    var speed = Double.random(in: 100 ... 200)
    var xDirection = Double.random(in:  -0.05 ... 0.05)
    var yDirection = Double.random(in: -Double.pi ...  0)
    
    var animatableData: Double {
        get { time }
        set { time = newValue }
    }
    func effectValue(size: CGSize) -> ProjectionTransform {
        let xTranslation = speed * xDirection
        let yTranslation = speed * sin(yDirection) * time
        let affineTranslation =  CGAffineTransform(translationX: xTranslation, y: yTranslation)
        return ProjectionTransform(affineTranslation)
    }
}


struct LikeTapModifier: ViewModifier {
    @State var time = 0.0
    let duration = 1.0
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .foregroundColor(.red)
                .modifier(LikesGeometryEffect(time: time))
                .opacity(time == 1 ? 0 : 1)
        }
        .onAppear {
            withAnimation (.easeOut(duration: duration)) {
                self.time = duration
            }
        }
    }
}

struct LikeView : Identifiable, Equatable {
    let image = Image(systemName: "heart.fill")
    let id = UUID()
}
