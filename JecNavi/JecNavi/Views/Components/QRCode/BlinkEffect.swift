import SwiftUI

struct BlinkEffect: ViewModifier {
    @State private var isOn: Bool = false
    let opacityRange: ClosedRange<Double>
    let interval: Double

    init(opacity: ClosedRange<Double>, interval: Double) {
        self.opacityRange = opacity
        self.interval = interval
    }

    func body(content: Content) -> some View {
        content
            .opacity(self.isOn ? self.opacityRange.lowerBound : self.opacityRange.upperBound)
            .onAppear {
                startBlinking()
            }
    }

    private func startBlinking() {
        Timer.scheduledTimer(withTimeInterval: self.interval, repeats: true) { _ in
            withAnimation(.linear(duration: self.interval)) {
                self.isOn.toggle()
            }
        }
    }
}

extension View {
    func blinkEffect(opacity: ClosedRange<Double> = 0.1...1, interval: Double = 0.6) -> some View {
        self.modifier(BlinkEffect(opacity: opacity, interval: interval))
    }
}
