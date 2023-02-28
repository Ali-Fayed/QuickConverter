//
//  CurrencyConvertorMocks.swift
//  CurrencyConvertorTests
//
//  Created by AliFayed on 27/02/2023.
//
import XCTest
import RxSwift
@testable import CurrencyConvertor
class CurrencyConvertorMocks: CurrencyConvertorRepositoryInterface {
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
    func getConvertedCurrencyValue(from: String, to: String, ammout: String) -> convertsReturnType {
        return CurrencyConvertorStubGenerator().stubCurrencyConverts()
            .flatMap { result -> Observable<ConvertedCurrencyDataModel> in
                let convertedResult = String(format: Constants.twoNumbersDouble, result.result)
                convertedResults = convertedResult
                fetchConvertedCalled = true
             return Observable.just(ConvertedCurrencyDataModel(convertedCurrencyResult: convertedResult))}!
    }
}
