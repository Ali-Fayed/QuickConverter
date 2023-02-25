//
//  CurrencyConvertorFactory.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 25/02/2023.
//
import UIKit
class CurrencyConvertorFactory {
    static func createCurrencyConvertorViewController(navigationController: UINavigationController) -> CurrencyConvertorViewController {
        let remote = CurrencyConvertorRemote()
        let repository = CurrencyConvertorRepository(currencySymbolService: remote)
        let useCase = CurrencyConvertorUseCase(currencySymbolRepository: repository)
        let viewModel = CurrencyConvertorViewModel(currencySymbolsUseCase: useCase)
        let viewController = CurrencyConvertorViewController.instaintiate(on: .main)
        viewController.initDependencies(viewModel: viewModel)
        viewController.title = Constants.currencyViewTitle
        viewController.navigationItem.hidesBackButton = true
        viewController.navigationItem.largeTitleDisplayMode = .always
        navigationController.navigationBar.prefersLargeTitles = true
        return viewController
    }
}
