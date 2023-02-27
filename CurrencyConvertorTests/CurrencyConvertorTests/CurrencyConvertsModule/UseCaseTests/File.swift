//
//  File.swift
//  CurrencyConvertorTests
//
//  Created by AliFayed on 27/02/2023.
//
import XCTest
import RxSwift
import RxTest
@testable import CurrencyConvertor
class FetchConvertedCurrencyTests: XCTestCase {
    /// Sut = System Under Test
    var sut: CurrencyConvertorRepository!
    /// Mock = Fake injection
    var mockRemoteService: CurrencyConvertorRemoteServiceMock!
    override func setUp() {
        super.setUp()
        mockRemoteService = CurrencyConvertorRemoteServiceMock()
        sut = CurrencyConvertorRepository(currencySymbolService: mockRemoteService)
    }
    override func tearDown() {
        mockRemoteService = nil
        sut = nil
        super.tearDown()
    }
    func testFetchConvertedCurrency() {
        // Given
        let symbolsEntity = mockRemoteService.fetchCurrencyConverts(from: "USD", to: "EGP", ammout: "5")
        _ = sut.getConvertedCurrency(from: "USD", to: "EGP", ammout: "5")
        guard let convertedResults = mockRemoteService.convertedResults else {return}
        let promise = XCTestExpectation(description: "converted currencies is fetched")
        // When
        if mockRemoteService.fetchConvertedCalled {
            promise.fulfill()
            wait(for: [promise], timeout: 1.0)
        }
        // Then
        XCTAssertTrue(mockRemoteService.fetchConvertedCalled)
        XCTAssertNotNil(symbolsEntity)
        XCTAssertEqual(convertedResults.result, 152.972935)
    }
}
