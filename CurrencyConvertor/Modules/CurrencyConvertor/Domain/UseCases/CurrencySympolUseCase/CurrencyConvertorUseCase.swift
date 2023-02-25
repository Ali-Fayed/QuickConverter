//
//  CurrencyConvertorUseCase.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 24/02/2023.
//
import Foundation
import RxSwift
class CurrencyConvertorUseCase: CurrencyConvertorUseCaseProtocol {
    private let currencySymbolRepository: CurrencyConvertorRepoProtocol
    init(currencySymbolRepository: CurrencyConvertorRepoProtocol) {
        self.currencySymbolRepository = currencySymbolRepository
    }
    func fetchCurrencySymbols() -> Observable<SympolsDataModelProtocol> {
        return currencySymbolRepository.getCurrencySymbols()
    }
    func fetchLatestCurrencyRates(from: String, to: String, amount: String) -> Observable<ConvertedCurrencyDataModelProtocol> {
        return currencySymbolRepository.getLatestCurrencyConvertedRates(from: from, to: to, ammout: amount)
    }
}
