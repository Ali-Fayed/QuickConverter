//
//  CurrencyDetailsRepository.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 25/02/2023.
//
import Foundation
import RxSwift
import RxCocoa
class CurrencyDetailsRepository: CurrencyDetailsRepoProtocol {
    private let currencyDetailsRemoteProtocol: CurrencyDetailsRemoteProtocol
    init(currencyDetailsRemoteProtocol: CurrencyDetailsRemoteProtocol) {
        self.currencyDetailsRemoteProtocol = currencyDetailsRemoteProtocol
    }
    func getHistoricalConverts(date: String, symbols: String, base: String) -> Observable<[HistoricalConvertsDataModel]> {
        return currencyDetailsRemoteProtocol.fetchHistoricalCurrencyConverts(date: date, symbols: symbols, base: base)
            .flatMap { currency -> Observable<[HistoricalConvertsDataModel]> in
                guard let values = currency.rates?.values.first else {
                    return Observable.just([])
                }
                let currencyModels = HistoricalConvertsDataModel(toCurrencyValue: String(values))
                return Observable.just([currencyModels])
            }
    }
    func fetchFamousConvertedCurrency(symbols: String, base: String) -> Observable<[FamousCurrenciesDataModel]> {
        return currencyDetailsRemoteProtocol.fetchFamousConvertedCurrency(symbols: symbols, base: base)
            .flatMap { currency -> Observable<[FamousCurrenciesDataModel]> in
                guard let symbols = currency.rates?.keys,
                      let values = currency.rates?.values else {
                    return Observable.just([])
                }
                var currencyModels: [FamousCurrenciesDataModel] = []
                for (symbol, value) in zip(symbols, values) {
                    let model = FamousCurrenciesDataModel(currencySymbol: symbol, currencyValue: String(value))
                    currencyModels.append(model)
                }
                return Observable.just(currencyModels)
            }
    }
}

