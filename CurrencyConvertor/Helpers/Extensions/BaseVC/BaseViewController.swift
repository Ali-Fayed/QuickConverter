//
//  BaseViewController.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 24/02/2023.
//

import Foundation
import UIKit
import Combine
class BaseViewController<T, F>:UIViewController, BaseVC {
    typealias V = T
    typealias C = F
    var viewModel: V?
    var coordinator: C?
    var subscriptions: Set<AnyCancellable> = []
    convenience init() {
        fatalError("init() has not been implemented")
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    required init(viewModel: V?, coordinator: C?, nibName: String? = nil) {
         super.init(nibName: nibName, bundle: nil)
         initDependencies(viewModel: viewModel, coordinator: coordinator)
    }
    func initDependencies(viewModel: V?, coordinator: C?) {
        self.viewModel = viewModel
        self.coordinator = coordinator
    }
}
