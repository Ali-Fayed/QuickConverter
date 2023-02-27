//
//  CurrencyConvertorMocks.swift
//  CurrencyConvertorTests
//
//  Created by AliFayed on 27/02/2023.
//
import XCTest
import RxSwift
@testable import CurrencyConvertor
class CurrencyConvertorMocks: CurrencyConvertorRepoProtocol {
    typealias symbolsReturnType = Observable<CurrencySymbolsDataModel>
    typealias convertsReturnType = Observable<ConvertedCurrencyDataModel>
    
    var fetchSymbolsCalled = false
    var fetchConvertedCalled = false
    
    var convertedResults: String?
    var symbolResult: [String]?
    
    func getCurrencySymbols() -> symbolsReturnType {
        return CurrencyConvertorStubGenerator().stubSymbols()
            .flatMap { result -> Observable<CurrencySymbolsDataModel> in
            let symbols = Array(result.symbols.keys)
                    symbolResult = symbols
                fetchSymbolsCalled = true
            return Observable.just(CurrencySymbolsDataModel(symbols: symbols))}!
    }
    func getConvertedCurrency(from: String, to: String, ammout: String) -> convertsReturnType {
        return CurrencyConvertorStubGenerator().stubCurrencyConverts()
            .flatMap { result -> Observable<ConvertedCurrencyDataModel> in
             let convertedResult = String(format: "%.2f", result.result)
                convertedResults = convertedResult
                fetchConvertedCalled = true
             return Observable.just(ConvertedCurrencyDataModel(convertedCurrencyResult: convertedResult))}!
    }
}
