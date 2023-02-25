//
//  Mocks.swift
//  CurrencyConvertorTests
//
//  Created by AliFayed on 25/02/2023.
//
import Foundation
import XCTest
import RxSwift
@testable import CurrencyConvertor
class CurrencyConvertorRepoMock: CurrencyConvertorRepoProtocol {
    var getCurrencySymbolsCallCount = 0
    var getSymbolsReturnValue: Observable<SympolsDataModelProtocol>!
    
    var getLatestCurrencyConvertedRatesCallCount = 0
    var getLatestCurrencyConvertedRatesReturnValue: Observable<ConvertedCurrencyDataModelProtocol>!
    
    func getCurrencySymbols() -> Observable<SympolsDataModelProtocol> {
        getCurrencySymbolsCallCount += 1
        return getSymbolsReturnValue
    }
    func getLatestCurrencyConvertedRates(from: String, to: String) -> Observable<ConvertedCurrencyDataModelProtocol> {
        getLatestCurrencyConvertedRatesCallCount += 1
        return getLatestCurrencyConvertedRatesReturnValue
    }
}


class CurrencySymbolsMock: SympolsDataModelProtocol {
    var sympol: [String : String]
    init(sympol: [String : String]) {
        self.sympol = sympol
    }
}

class LatestRatesMock: ConvertedCurrencyDataModelProtocol {
    var rates: [String : Double]
    init(rates: [String : Double]) {
        self.rates = rates
    }
}
