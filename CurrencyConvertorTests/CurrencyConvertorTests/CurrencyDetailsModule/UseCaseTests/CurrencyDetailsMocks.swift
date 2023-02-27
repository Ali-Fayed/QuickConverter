//
//  CurrencyDetailsRepoMocks.swift
//  CurrencyConvertorTests
//
//  Created by AliFayed on 27/02/2023.
//
import XCTest
import RxSwift
@testable import CurrencyConvertor
class CurrencyDetailsUseCaseMocks: CurrencyDetailsRepoProtocol {
    typealias hisotricalRetunType = Observable<[HistoricalConvertsDataModel]>
    typealias famousReturnType = Observable<[FamousCurrenciesDataModel]>
    
    var fetchHistoicalConvertsCalled = false
    var fetchFamousCurrenciesCalled = false
    
    var hisoticalConvertsResult: [HistoricalConvertsDataModel]?
    var famousConvertsResult: [FamousCurrenciesDataModel]?
    
    func getHistoricalConverts(startDate: String, endDate: String, base: String, symbols: String) -> hisotricalRetunType {
        // Stub response from taking the value from the internal local json
        DetailsStubGenerator().stubHistoricalConverts()
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
                hisoticalConvertsResult = currencyModels
                fetchHistoicalConvertsCalled = true
                return Observable.just(currencyModels)
        }!
    }
    
    func getFamousConvertes(symbols: String, base: String) -> famousReturnType {
        // Stub response from taking the value from the internal local json
       return DetailsStubGenerator().stubFamousCurrencyConverts()
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
                famousConvertsResult = currencyModels
                fetchFamousCurrenciesCalled = true
                return Observable.just(currencyModels)
            }!
    }
}
