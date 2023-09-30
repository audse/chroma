//
//  NumberStepper.swift
//  Chroma
//
//  Created by Audrey Serene on 9/30/23.
//

import SwiftUI

struct NumberStepper: View {
    @Binding var value: Double
    
    @State var range: ClosedRange<Double> = (-.infinity)...(.infinity)
    @State var step: Double = 1
    @State var formatter: NumberFormatter
    @State var fontSize: CGFloat = 12
    @State var expectedDigits: Int?
    
    var body: some View {
        HStack(spacing: 4) {
            makeButton("minus", decrement)
            Text(formatter.str(value) ?? "")
                .foregroundColor(.secondary.lerp(.primary, by: 0.25))
                .monospacedDigit()
                .frame(minWidth: CGFloat(getExpectedDigits()) * (fontSize * 0.75))
            makeButton("plus", increment)
        }
        .font(.system(size: fontSize, weight: .semibold))
        .background(Color.almostClear)
        .padding(2)
        .overlay(
            RoundedRectangle(cornerRadius: 4)
                .stroke(.tertiary, lineWidth: 2)
        )
        .padding(1)
        .scaleOnTap()
    }
    
    private func makeButton(_ icon: String, _ action: @escaping () -> Void) -> some View {
        Button { action() } label: {
            Image(systemName: icon)
                .frame(width: fontSize + 2, height: fontSize + 2)
                .background(Color.almostClear)
        }.buttonStyle(.plain)
    }
    
    private func increment() {
        value = (value + step).clamp(low: range.lowerBound, high: range.upperBound)
    }
    
    private func decrement() {
        value = (value - step).clamp(low: range.lowerBound, high: range.upperBound)
    }
    
    private func getExpectedDigits() -> Int {
        if let expectedDigits {
            return expectedDigits
        }
        if range.upperBound < .infinity {
            if let str = formatter.str(range.upperBound) {
                return str.count
            }
        }
        return 10
    }
}

#Preview {
    NumberStepper(
        value: .constant(0.5),
        range: 0...1,
        formatter: {
            var format = NumberFormatter()
            format.numberStyle = .percent
            return format
        }()
    )
}
