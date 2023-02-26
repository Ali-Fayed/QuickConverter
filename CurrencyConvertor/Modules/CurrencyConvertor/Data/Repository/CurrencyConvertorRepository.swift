//
//  CurrencyConvertorRepository.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 24/02/2023.
//
import Foundation
import RxSwift
class CurrencyConvertorRepository: CurrencyConvertorRepoProtocol {
    typealias symbolsReturnType = Observable<CurrencySymbolsDataModel>
    typealias convertsReturnType = Observable<ConvertedCurrencyDataModel>
    private let currencySymbolService: CurrencyConvertorRemoteProtocol
    init(currencySymbolService: CurrencyConvertorRemoteProtocol) {
        self.currencySymbolService = currencySymbolService
    }
    func getCurrencySymbols() -> symbolsReturnType {
        return currencySymbolService.fetchCurrencySymbols()
            .flatMap { result -> Observable<CurrencySymbolsDataModel> in
                let symbols = Array(result.symbols.keys)
                return Observable.just(CurrencySymbolsDataModel(sympols: symbols))
            }
    }
    func getConvertedCurrency(from: String, to: String, ammout: String) -> convertsReturnType {
        return currencySymbolService.fetchCurrencyConverts(from: from, to: to, ammout: ammout)
            .flatMap { result -> Observable<ConvertedCurrencyDataModel> in
                let convertedResult = String(format: "%.2f", result.result)
                return Observable.just(ConvertedCurrencyDataModel(convertedCurrencyResult: convertedResult))
            }
    }
}
