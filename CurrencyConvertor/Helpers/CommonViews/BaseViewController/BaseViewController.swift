//
//  BaseViewController.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 24/02/2023.
//
import Foundation
import UIKit
import RxSwift
class BaseViewController<T>: CommonViews, BaseVC {
    typealias V = T
    var viewModel: V?
    let disposeBag = DisposeBag()
    convenience init() {
        fatalError("init() has not been implemented")
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    required init(viewModel: V?, nibName: String? = nil) {
         super.init(nibName: nibName, bundle: nil)
         initDependencies(viewModel: viewModel)
    }
    func initDependencies(viewModel: V?) {
        self.viewModel = viewModel
    }
}
