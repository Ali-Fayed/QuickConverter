//
//  CurrencyConvertorRepositoryMocks.swift
//  CurrencyConvertorTests
//
//  Created by AliFayed on 27/02/2023.
//
import XCTest
import RxSwift
@testable import CurrencyConvertor
class CurrencyConvertorRemoteServiceMock: CurrencyConvertorRemoteProtocol {
    typealias symbolsReturnType = Observable<CurrencySymbolsEntity>
    typealias CurrencyConvertReturnType = Observable<CurrencyConvertEntity>
    var fetchSymbolsCalled = false
    var fetchConvertedCalled = false
    var convertedResults: CurrencyConvertEntity?
    var symbolResult: CurrencySymbolsEntity?
    func fetchCurrencySymbols() -> symbolsReturnType {
        if let symbols = RepoStubGenerator().stubSymbols() {
            symbolResult = symbols
            fetchSymbolsCalled = true
            return Observable.just(symbols)
        } else {
            fetchSymbolsCalled = false
            XCTFail("Failed to generate symbols")
            return Observable.error(MockError.mockError)
        }
    }
    func fetchCurrencyConverts(from: String, to: String, ammout: String) -> CurrencyConvertReturnType {
        if let convertedResult = RepoStubGenerator().stubCurrencyConverts() {
            convertedResults = convertedResult
            fetchConvertedCalled = true
            return Observable.just(convertedResult)
        } else {
            fetchConvertedCalled = false
            XCTFail("Failed to generate converts")
            return Observable.error(MockError.mockError)
        }
    }
}
enum MockError: Error {
    case mockError
}
