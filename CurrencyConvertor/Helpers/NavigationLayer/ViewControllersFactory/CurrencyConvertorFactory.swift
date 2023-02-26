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
        let symbolsUseCase = FetchCurrencySymbolsUseCase(currencySymbolRepository: repository)
        let convertCurrencyUseCase = FetchConvertedCurrencyUseCase(currencySymbolRepository: repository)
        let viewModel = CurrencyConvertorViewModel(convertCurrencyUseCase: convertCurrencyUseCase, fetchSymbolsUseCase: symbolsUseCase)
        let viewController = CurrencyConvertorViewController.instaintiate(on: .main)
        viewController.initDependencies(viewModel: viewModel)
        viewController.title = Constants.currencyViewTitle
        viewController.navigationItem.hidesBackButton = true
        viewController.navigationItem.largeTitleDisplayMode = .always
        navigationController.navigationBar.prefersLargeTitles = true
        return viewController
    }
}
