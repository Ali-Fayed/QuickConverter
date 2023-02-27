//
//  FetchCurrencySymbolsUseCase.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 24/02/2023.
//
import Foundation
import RxSwift
class CurrencySymbolsUseCase: CurrencySymbolsUseCaseInterface {
    // MARK: - Properties
    typealias returnType = Observable<CurrencySymbolsDataModel>
    private let currencySymbolRepository: CurrencyConvertorRepositoryInterface
    // MARK: - Intializer
    init(currencySymbolRepository: CurrencyConvertorRepositoryInterface) {
        self.currencySymbolRepository = currencySymbolRepository
    }
    // MARK: - Use Case Excution Method
    /// - Description: Send Use Case Value to The Repository
    func excute() -> returnType {
        return currencySymbolRepository.getCurrencySymbols()
    }
}
