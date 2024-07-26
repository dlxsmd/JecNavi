//
//  EdgeSwipe.swift
//  JecNavi
//
//  Created by yuki on 2024/07/04.
//

import Foundation
import SwiftUI

struct EdgeSwipe: ViewModifier {
    @Environment(\.dismiss) var dismiss

    private let edgeWidth: Double = 30
    private let baseDragWidth: Double = 30
    
    func body(content: Content) -> some View {
        content
            .gesture (
                DragGesture().onChanged { value in
                    if value.startLocation.x < edgeWidth && value.translation.width > baseDragWidth {
                        dismiss()
                    }
                }
            )
    }
}

extension View {
    
    func edgeSwipe() -> some View {
        self.modifier(EdgeSwipe())
    }
}
