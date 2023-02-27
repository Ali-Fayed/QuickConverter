//
//  FamousCurrencyConvertsUseCaseTests.swift
//  CurrencyConvertorTests
//
//  Created by AliFayed on 27/02/2023.
//
import XCTest
import RxSwift
@testable import CurrencyConvertor
final class FamousCurrencyConvertsUseCaseTests: XCTestCase {
    /// Sut = System Under Test
    var sut: FamousCurrenciesUseCase!
    /// Mock = Fake injection
    var mockRepo: CurrencyDetailsUseCaseMocks!
    override func setUp() {
        super.setUp()
        mockRepo = CurrencyDetailsUseCaseMocks()
        sut = FamousCurrenciesUseCase(currencyDetailsRepoProtocol: mockRepo)
    }
    override func tearDown() {
        mockRepo = nil
        sut = nil
        super.tearDown()
    }
    func testFetchFamousCurrencyRates() {
        // Given
        let repoMockOutput = mockRepo.getFamousConvertes(symbols: "EGP", base: "USD")
        let useCaseOutput = sut.excute(symbols: "EGP", base: "USD")
        guard let result = mockRepo.famousConvertsResult else {return}
        let promise = XCTestExpectation(description: "famous converts is fetched")
        // When
        if useCaseOutput === repoMockOutput {
            promise.fulfill()
            wait(for: [promise], timeout: 3.0)
        }
        // Then
        XCTAssertTrue(mockRepo.fetchFamousCurrenciesCalled)
        XCTAssertNotNil(repoMockOutput)
        XCTAssertNotNil(useCaseOutput)
        XCTAssertNotNil(result)
        XCTAssertEqual(result[0].currencySymbol.count, 3)
        XCTAssertEqual(result.count, 12)
    }
}
