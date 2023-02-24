//
//  CommonViews.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 24/02/2023.
//
import UIKit
class CommonViews: UIViewController {
    lazy var activityIndicator: UIActivityIndicatorView = {
      let activityIndicator = UIActivityIndicatorView()
      activityIndicator.center = view.center
      activityIndicator.style = .large
      activityIndicator.translatesAutoresizingMaskIntoConstraints = false
      activityIndicator.hidesWhenStopped = true
      activityIndicator.color = .black
      view.addSubview(activityIndicator)
      NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
      return activityIndicator
  }()
}
