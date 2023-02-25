//
//  CurrencyChart.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 25/02/2023.
//
import UIKit
import SwiftUI
struct CurrencyChart: View {
    var measurements: [Measurement]
    var body: some View {
        HStack(alignment: .bottom) {
            Spacer()
            ForEach(measurements, id: \.self) { measurement in
                VStack {
                    Spacer()
                    Text(String(format: "%.1f", measurement.rate))
                        .font(.footnote)
                        .rotationEffect(.degrees(-90))
                        .offset(y: measurement.rate < 2.4 ? 0 : 35)
                        .zIndex(1)
                    Rectangle()
                        .fill(Color.green)
                        .frame(width: 20, height: CGFloat(measurement.rate) * 4.0)
                    Text(measurement.date)
                        .font(.footnote)
                        .frame(height: 20)
                }.padding(.leading, 10)
            }
            Spacer()
        }.clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(color: Color.gray.opacity(0.5), radius: 10, x: 0, y: 0)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
            ).frame(height: 200)
    }
}
