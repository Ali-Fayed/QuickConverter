////
////  CurrencyConvertorTests.swift
////  CurrencyConvertorTests
////
////  Created by AliFayed on 23/02/2023.
////
//import XCTest
//import RxSwift
//@testable import CurrencyConvertor
//class CurrencyConvertorUseCaseTests: XCTestCase {
//    var sut: CurrencyConvertorUseCase!
//    var currencySymbolRepositoryMock: CurrencyConvertorRepoMock!
//    
//    override func setUp() {
//        super.setUp()
//        currencySymbolRepositoryMock = CurrencyConvertorRepoMock()
//        sut = CurrencyConvertorUseCase(currencySymbolRepository: currencySymbolRepositoryMock)
//    }
//    
//    override func tearDown() {
//        sut = nil
//        currencySymbolRepositoryMock = nil
//        super.tearDown()
//    }
//    
//    func testFetchCurrencySymbols_callsRepository() {
//        // given
//        let symbols = ["USD": "United States Dollar", "EUR": "Euro", "JPY": "Japanese Yen"]
//        let expectedSymbols = CurrencySymbolsMock(sympol: symbols)
//        currencySymbolRepositoryMock.getSymbolsReturnValue = Observable.just(expectedSymbols)
//        // when
//        _ = sut.fetchCurrencySymbols().subscribe()
//        // then
//        XCTAssertEqual(currencySymbolRepositoryMock.getCurrencySymbolsCallCount, 1)
//    }
//    
//    func testFetchLatestCurrencyRates_callsRepository() {
//        // given
//        let expectedRates = LatestRatesMock(rates: ["USD": 1.0, "EUR": 0.82, "JPY": 108.97])
//        currencySymbolRepositoryMock.getLatestCurrencyConvertedRatesReturnValue = Observable.just(expectedRates)
//        // when
//        _ = sut.fetchLatestCurrencyRates(from: "USD", to: "EUR").subscribe()
//        // then
//        XCTAssertEqual(currencySymbolRepositoryMock.getLatestCurrencyConvertedRatesCallCount, 1)
//    }
//}
