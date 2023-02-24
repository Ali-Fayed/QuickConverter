//
//  SplashViewController.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 23/02/2023.
//
import UIKit
class SplashViewController: UIViewController {
    // MARK: - Properties
    var coordinator: AppCoordinator?
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigateToCurrencyViewController()
    }
    // MARK: - Main Methods
    func navigateToCurrencyViewController() {
        coordinator?.showCurrencyViewController(viewController: self)
    }
}
