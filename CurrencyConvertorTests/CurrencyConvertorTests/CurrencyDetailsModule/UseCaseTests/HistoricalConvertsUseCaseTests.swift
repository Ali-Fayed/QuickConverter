//
//  HistoricalConvertsUseCaseTests.swift
//  CurrencyConvertorTests
//
//  Created by AliFayed on 27/02/2023.
//
import XCTest
@testable import CurrencyConvertor
final class HistoricalConvertsUseCaseTests: XCTestCase {
    /// Sut = System Under Test
    var sut: HistoricalConvertsUseCase!
    /// Mock = Fake injection
    var mockRemoteService: CurrencyDetailsUseCaseMocks!
    override func setUp() {
        super.setUp()
        mockRemoteService = CurrencyDetailsUseCaseMocks()
        sut = HistoricalConvertsUseCase(currencyDetailsRepoProtocol: mockRemoteService)
    }
    override func tearDown() {
        mockRemoteService = nil
        sut = nil
        super.tearDown()
    }
    func testFetchCurrencyHistoricalConverts() {
        // Given
        let repoMockOutput = mockRemoteService.getHistoricalConverts(startDate: "2023-02-25", endDate: "2023-02-27", base: "USD", symbols: "EGP")
        let useCaseOutput = sut.excute(startDate: "2023-02-25", endDate: "2023-02-27", base: "USD", symbols: "EGP")
        guard let result = mockRemoteService.hisoticalConvertsResult else {return}
        let promise = XCTestExpectation(description: "historical converts is fetched")
        // When
        if useCaseOutput ===  useCaseOutput {
            promise.fulfill()
            wait(for: [promise], timeout: 3.0)
        }
        // Then
        XCTAssertTrue(mockRemoteService.fetchHistoicalConvertsCalled)
        XCTAssertNotNil(repoMockOutput)
        XCTAssertNotNil(useCaseOutput)
        XCTAssertNotNil(result)
        XCTAssertEqual(result.count, 3)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        XCTAssertNotNil(formatter.date(from: result[0].dateString), "Date string should be in format yyyy-MM-dd")
        XCTAssertEqual(result[0].fromCurrencySymbol.count, 3)
        XCTAssertEqual(result[0].fromCurrencySymbol.count, 3)
    }
}
