//
//  CurrencyDetailsFactory.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 25/02/2023.
//
import UIKit
class CurrencyDetailsFactory {
    static func createCurrencyDetailsViewController(navigationController: UINavigationController) -> CurrencyDetailsViewController {
        let remote = CurrencyDetailsRemoteServices()
        let repository = CurrencyDetailsRepository(currencyDetailsRemoteProtocol: remote)
        let historicalUseCase = HistoricalConvertsUseCase(currencyDetailsRepoProtocol: repository)
        let famousConvertsUseCase = FamousCurrenciesUseCase(currencyDetailsRepoProtocol: repository)
        let viewModel = CurrencyDetailsViewModel(historicalConvertsUseCase: historicalUseCase, famousCurrenciesConvertsUseCase: famousConvertsUseCase)
        let viewController = CurrencyDetailsViewController.instaintiate(on: .main)
        viewController.initDependencies(viewModel: viewModel)
        viewController.title = Constants.currencyDetailsViewtitle
        return viewController
    }
}
