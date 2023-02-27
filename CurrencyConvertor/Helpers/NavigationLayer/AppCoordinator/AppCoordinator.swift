//
//  AppCoordinator.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 24/02/2023.
//
import UIKit
class AppCoordinator: Coordinator {
    //MARK: - Properties
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    //MARK: - Intializer
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    //MARK: - Methods
    /// the first view controller to show
    func start() {
        let viewController = CurrencyConvertorFactory.createCurrencyConvertorViewController(navigationController: navigationController)
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    /// naviagte to the details vc
    /// - Parameters:
    ///   - fromSympol: from symbol you need to convert
    ///   - toSympol: to symbol you need to convert to
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
