//
//  AppCoordinator.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 24/02/2023.
//
import UIKit
class AppCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    func start() {
        let viewController = CurrencyConvertorFactory.createCurrencyConvertorViewController(navigationController: navigationController)
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    func showCurrencyDetailsViewController(fromSympol: String, toSympol: String, fromValue: String) {
        let viewController = CurrencyDetailsFactory.createCurrencyDetailsViewController(navigationController: navigationController)
        guard let viewModel = viewController.viewModel else {return}
        viewModel.fromCurrencySymbol = fromSympol
        viewModel.toCurrencySymbol = toSympol
        viewModel.fromCurrencyValue = fromValue
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
}
