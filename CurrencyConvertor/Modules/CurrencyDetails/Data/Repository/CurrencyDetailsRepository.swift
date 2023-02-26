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
    typealias hisotricalRetunType = Observable<[HistoricalConvertsDataModel]>
    typealias famousReturnType = Observable<[FamousCurrenciesDataModel]>
    private let currencyDetailsRemoteProtocol: CurrencyDetailsRemoteProtocol
    init(currencyDetailsRemoteProtocol: CurrencyDetailsRemoteProtocol) {
        self.currencyDetailsRemoteProtocol = currencyDetailsRemoteProtocol
    }
    func getHistoricalConverts(date: String, symbols: String, base: String) -> hisotricalRetunType{
        return currencyDetailsRemoteProtocol.fetchHistoricalConverts(date: date, symbols: symbols, base: base)
            .flatMap { currency -> Observable<[HistoricalConvertsDataModel]> in
                guard let value = currency.rates?.values.first else {
                    return Observable.just([])
                }
                let shortValue = String(format: "%.2f", value)
                let currencyModels = HistoricalConvertsDataModel(toCurrencyValue: String(shortValue))
                return Observable.just([currencyModels])
            }
    }
    func getFamousConvertes(symbols: String, base: String) -> famousReturnType {
        return currencyDetailsRemoteProtocol.fetchFamousConvertes(symbols: symbols, base: base)
            .flatMap { currency -> Observable<[FamousCurrenciesDataModel]> in
                guard let symbols = currency.rates?.keys,
                      let values = currency.rates?.values else {
                    return Observable.just([])
                }
                var currencyModels: [FamousCurrenciesDataModel] = []
                for (symbol, value) in zip(symbols, values) {
                    let shortValue = String(format: "%.2f",value)
                    let model = FamousCurrenciesDataModel(currencySymbol: symbol, currencyValue: shortValue)
                    currencyModels.append(model)
                }
                return Observable.just(currencyModels)
            }
    }
}

