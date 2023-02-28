//
//  CurrencyConvertorFactory.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 25/02/2023.
//
import UIKit
class CurrencyConvertorFactory {
    static func createCurrencyConvertorViewController(navigationController: UINavigationController) -> CurrencyConvertorViewController {
        let remote = CurrencyConvertorRemoteService()
        let repository = CurrencyConvertorRepository(currencySymbolService: remote)
        let symbolsUseCase = CurrencySymbolsUseCase(currencySymbolRepository: repository)
        let convertCurrencyUseCase = ConvertedCurrencyUseCase(currencySymbolRepository: repository)
        let viewModel = CurrencyConvertorViewModel(convertCurrencyUseCase: convertCurrencyUseCase, currencySymbolsUseCase: symbolsUseCase)
        let viewController = CurrencyConvertorViewController.instaintiate(on: .main)
        viewController.initDependencies(viewModel: viewModel)
        viewController.title = CoordinatorConstants.currencyViewTitle
        viewController.navigationItem.largeTitleDisplayMode = .always
        navigationController.navigationBar.prefersLargeTitles = true
        return viewController
    }
}
