//
//  CurrencyDetailsFactory.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 25/02/2023.
//
import UIKit
class CurrencyDetailsFactory {
    static func createCurrencyDetailsViewController(navigationController: UINavigationController) -> CurrencyDetailsViewController {
        let remote = CurrencyDetailsRemote()
        let repository = CurrencyDetailsRepository(currencyDetailsRemoteProtocol: remote)
        let useCase = CurrencyDetailsUseCase(currencyDetailsRepoProtocol: repository)
        let viewModel = CurrencyDetailsViewModel(currencyDetailsUseCase: useCase)
        let viewController = CurrencyDetailsViewController.instaintiate(on: .main)
        viewController.initDependencies(viewModel: viewModel)
        viewController.title = Constants.currencyDetailsViewtitle
        return viewController
    }
}
