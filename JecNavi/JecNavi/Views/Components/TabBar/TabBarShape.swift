//
//  TabBarShape.swift
//  JecNavi
//
//  Created by yuki on 2024/06/15.
//

import Foundation
import SwiftUI

struct TabBarShape: Shape {
    let insetRadius: CGFloat
    let cornerRadius = CGFloat(25)
    let insetCornerAngle = 45.0

    func path(in rect: CGRect) -> Path {
        var path = Path()

        // Start just below the top-left corner
        var x = rect.minX
        var y = rect.minY + cornerRadius
        path.move(to: CGPoint(x: x, y: y))

        // Add the rounded corner on the top-left corner
        x += cornerRadius
        path.addArc(
            center: CGPoint(x: x, y: y),
            radius: cornerRadius,
            startAngle: .degrees(180),
            endAngle: .degrees(270),
            clockwise: false
        )
        // Begin inset in middle, cutting into shape
        x = rect.midX - (2 * insetRadius)
        y = rect.minY + insetRadius
        path.addArc(
            center: CGPoint(x: x, y: y),
            radius: insetRadius,
            startAngle: .degrees(270),
            endAngle: .degrees(270 + insetCornerAngle),
            clockwise: false
        )
        // Add a half-circle to fit the button
        x = rect.midX
        y = rect.minY
        path.addArc(
            center: CGPoint(x: x, y: y),
            radius: insetRadius,
            startAngle: .degrees(90 + insetCornerAngle),
            endAngle: .degrees(90 - insetCornerAngle),
            clockwise: true
        )
        // Complete the inset with the second rounded corner
        x += (2 * insetRadius)
        y += insetRadius
        path.addArc(
            center: CGPoint(x: x, y: y),
            radius: insetRadius,
            startAngle: .degrees(270 - insetCornerAngle),
            endAngle: .degrees(270),
            clockwise: false
        )
        // Top-right corner
        x = rect.maxX - cornerRadius
        y = rect.minY + cornerRadius
        path.addArc(
            center: CGPoint(x: x, y: y),
            radius: cornerRadius,
            startAngle: .degrees(270),
            endAngle: .degrees(0),
            clockwise: false
        )
        // Bottom-right corner
        y = rect.maxY - cornerRadius
        path.addArc(
            center: CGPoint(x: x, y: y),
            radius: cornerRadius,
            startAngle: .degrees(0),
            endAngle: .degrees(90),
            clockwise: false
        )
        // Bottom-left corner
        x = rect.minX + cornerRadius
        path.addArc(
            center: CGPoint(x: x, y: y),
            radius: cornerRadius,
            startAngle: .degrees(90),
            endAngle: .degrees(180),
            clockwise: false
        )
        path.closeSubpath()
        return path
    }
}
