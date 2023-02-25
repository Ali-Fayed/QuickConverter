//
//  MyTableViewHeaderView.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 25/02/2023.
//
import UIKit
import SwiftUI
class MyTableViewHeaderView: UIView {
    var measurements: [Measurement]
       
    init(frame: CGRect, measurements: [Measurement]) {
           self.measurements = measurements
           super.init(frame: frame)
        let mySwiftUIView = CurrencyChart(measurements: measurements)
        let hostingController = UIHostingController(rootView: mySwiftUIView)
        
        addSubview(hostingController.view)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: bottomAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
