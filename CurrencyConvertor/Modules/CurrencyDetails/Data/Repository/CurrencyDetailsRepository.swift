//
//  CurrencyDetailsRepository.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 25/02/2023.
//
import Foundation
import RxSwift
class CurrencyDetailsRepository: CurrencyDetailsRepoProtocol {
    typealias hisotricalRetunType = Observable<[HistoricalConvertsDataModel]>
    typealias famousReturnType = Observable<[FamousCurrenciesDataModel]>
    private let currencyDetailsRemoteProtocol: CurrencyDetailsRemoteProtocol
    init(currencyDetailsRemoteProtocol: CurrencyDetailsRemoteProtocol) {
        self.currencyDetailsRemoteProtocol = currencyDetailsRemoteProtocol
    }
    func getHistoricalConverts(startDate: String, endDate: String, base: String, symbols: String) -> hisotricalRetunType {
        return currencyDetailsRemoteProtocol.fetchHistoricalConverts(startDate: startDate, endDate: endDate, base: base, symbols: symbols)
            .flatMap { currency -> Observable<[HistoricalConvertsDataModel]> in
                guard let values = currency.rates else {
                    return Observable.just([])
                }
                var currencyModels: [HistoricalConvertsDataModel] = []
                for (dateString, ratesDictionary) in values {
                    let rates = Array(ratesDictionary.values)
                    let symbol = Array(ratesDictionary.keys).first ?? ""
                    for rate in rates {
                        let formattedRate = String(format: "%.2f", rate)
                        let model = HistoricalConvertsDataModel(
                            fromCurrencySymbol: currency.base ?? "",
                            fromCurrencyValue: "",
                            toCurrencySymobl: symbol,
                            toCurrencyValue: formattedRate,
                            dateString: dateString
                        )
                        currencyModels.append(model)
                    }
                }
                currencyModels = currencyModels.sorted { (model1, model2) -> Bool in
                    return model1.dateString > model2.dateString
                }
                return Observable.just(currencyModels)
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

