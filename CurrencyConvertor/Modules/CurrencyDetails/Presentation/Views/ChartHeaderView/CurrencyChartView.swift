//
//  CurrencyChartView.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 25/02/2023.
//
import UIKit
import SwiftUI
struct CurrencyChartView: View {
    var measurements: [ChartMeasurmentDataModel]
    var body: some View {
        HStack(alignment: .bottom) {
            Spacer()
            ForEach(measurements, id: \.self) { measurement in
                VStack {
                    Spacer()
                    Text(String(format: "%.2f", measurement.rate))
                        .font(.system(size: min(12, CGFloat(measurement.rate) * 4.0 / 3)))
                        .rotationEffect(.degrees(-90))
                        .offset(y: measurement.rate < 2.4 ? 0 : 35)
                        .zIndex(1)
                    Rectangle()
                        .fill(Color.green)
                        .frame(width: 20, height: min(CGFloat(measurement.rate) * 4.0, 150))
                    Text(measurement.date)
                        .font(.footnote)
                        .frame(height: 20)
                }.padding(.leading, 10)
            }
            Spacer()
        }.frame(height: 150).clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(color: Color.gray.opacity(0.5), radius: 10, x: 0, y: 0)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
            )
    }
}
