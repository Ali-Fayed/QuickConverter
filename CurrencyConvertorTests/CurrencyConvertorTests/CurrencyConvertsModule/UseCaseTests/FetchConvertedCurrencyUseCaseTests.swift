//
//  FetchConvertedCurrencyUseCaseTests.swift
//  CurrencyConvertorTests
//
//  Created by AliFayed on 27/02/2023.
//
import XCTest
@testable import CurrencyConvertor
class FetchConvertedCurrencyUseCaseTests: XCTestCase {
    /// Sut = System Under Test
    var sut: FetchConvertedCurrencyUseCase!
    /// Mock = Fake injection
    var mockRemoteService: CurrencyConvertorRemoteServiceMock!
    override func setUp() {
        super.setUp()
        mockRemoteService = CurrencyConvertorRemoteServiceMock()
        sut = FetchConvertedCurrencyUseCase(currencySymbolRepository: mockRemoteService)
    }
    override func tearDown() {
        mockRemoteService = nil
        sut = nil
        super.tearDown()
    }
    func testFetchConvertedCurrency() {
        // Given
        let repoMockOutput = mockRemoteService.getConvertedCurrency(from: "USD", to: "EGP", ammout: "5")
        let useCaseOutput = sut.excute(from: "USD", to: "EGP", amount: "5")
        guard let convertedResults = mockRemoteService.convertedResults else {return}
        let promise = XCTestExpectation(description: "converted currencies is fetched")
        // When
        if useCaseOutput === repoMockOutput {
            promise.fulfill()
            wait(for: [promise], timeout: 3.0)
        }
        // Then
        XCTAssertTrue(mockRemoteService.fetchConvertedCalled)
        XCTAssertNotNil(repoMockOutput)
        XCTAssertNotNil(useCaseOutput)
        XCTAssertEqual(convertedResults, "152.97")
    }
}
