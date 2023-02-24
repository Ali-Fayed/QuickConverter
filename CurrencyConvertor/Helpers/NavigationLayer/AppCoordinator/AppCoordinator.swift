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
        let splashViewController = SplashViewController.instaintiate(on: .main)
        splashViewController.coordinator = self
        navigationController.pushViewController(splashViewController, animated: true)
    }
    func showCurrencyViewController() {
        let remote = CurrencyConvertorRemote()
        let repository = CurrencyConvertorRepository(currencySymbolService: remote)
        let useCase = CurrencyConvertorUseCase(currencySymbolRepository: repository)
        let viewModel = CurrencyConvertorViewModel(currencySymbolsUseCase: useCase)
        let viewController = CurrencyConvertorViewController.instaintiate(on: .main)
        viewController.initDependencies(viewModel: viewModel)
        viewController.coordinator = self
        viewController.title = Constants.currencyViewTitle
        viewController.navigationItem.hidesBackButton = true
        viewController.navigationItem.largeTitleDisplayMode = .always
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.pushViewController(viewController, animated: true)
    }
    func showCurrencyDetailsViewController() {
        let viewModel = CurrencyDetailsViewModel()
        let viewController = CurrencyDetailsViewController(viewModel: viewModel, nibName: Constants.currencyDetailsViewNib)
        viewController.coordinator = self
        viewController.title = Constants.currencyDetailsViewtitle
        navigationController.pushViewController(viewController, animated: true)
    }
}
