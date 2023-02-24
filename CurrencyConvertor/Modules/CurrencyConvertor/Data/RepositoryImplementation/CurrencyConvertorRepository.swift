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
    func getCurrencySymbols() -> Observable<CurrencySympolsEntity> {
        return currencySymbolService.fetchCurrencySymbols()
    }
    func getLatestCurrencyConvertedRates(from: String, to: String) -> Observable<CurrencyRatesEntity> {
        return currencySymbolService.fetchLatestCurrencyConverts(from: from, to: to)
    }
}
