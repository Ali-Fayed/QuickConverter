//
//  FetchCurrencySymbolsUseCaseTests.swift
//  CurrencyConvertorTests
//
//  Created by AliFayed on 27/02/2023.
//
import XCTest
@testable import CurrencyConvertor
class FetchCurrencySymbolsUseCaseTests: XCTestCase {
    /// Sut = System Under Test
    var sut: FetchCurrencySymbolsUseCase!
    /// Mock = Fake injection
    var mockRemoteService: CurrencyConvertorRemoteServiceMock!
    override func setUp() {
        super.setUp()
        mockRemoteService = CurrencyConvertorRemoteServiceMock()
        sut = FetchCurrencySymbolsUseCase(currencySymbolRepository: mockRemoteService)
    }
    override func tearDown() {
        mockRemoteService = nil
        sut = nil
        super.tearDown()
    }
    func testFetchCurrencySymbols() {
        // Given
        let repoMockOutput = mockRemoteService.getCurrencySymbols()
        let useCaseOutput = sut.excute()
        guard let result = mockRemoteService.symbolResult else {return}
        let promise = XCTestExpectation(description: "symbols is fetched")
        // When
        if useCaseOutput === repoMockOutput {
            promise.fulfill()
            wait(for: [promise], timeout: 3.0)
        }
        // Then
        XCTAssertTrue(mockRemoteService.fetchSymbolsCalled)
        XCTAssertNotNil(result)
        XCTAssertNotNil(repoMockOutput)
        XCTAssertNotNil(useCaseOutput)
        XCTAssertEqual(result.count, 170)
        XCTAssertEqual(result[0].count, 3)
    }
}
