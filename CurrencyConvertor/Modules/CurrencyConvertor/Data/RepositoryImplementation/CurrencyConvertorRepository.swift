//
//  CurrencyConvertorRepository.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 24/02/2023.
//
import Foundation
import RxSwift
class CurrencyConvertorRepository: CurrencyConvertorRepoProtocol {
    private let currencySymbolService: CurrencyConvertorRemoteProtocol
    init(currencySymbolService: CurrencyConvertorRemoteProtocol) {
        self.currencySymbolService = currencySymbolService
    }
    func getCurrencySymbols() -> Observable<SympolsDataModelProtocol> {
        return currencySymbolService.fetchCurrencySymbols()
            .map { CurrencySympols(sympol: $0.symbols) }
            .asObservable()
    }
    func getLatestCurrencyConvertedRates(from: String, to: String, ammout: String) -> Observable<ConvertedCurrencyDataModelProtocol> {
        return currencySymbolService.fetchLatestCurrencyConverts(from: from, to: to, ammout: ammout)
            .map { ConvertedCurrencyData(convertedCurrencyResult: String($0.result)) }
            .asObservable()
    }
}
